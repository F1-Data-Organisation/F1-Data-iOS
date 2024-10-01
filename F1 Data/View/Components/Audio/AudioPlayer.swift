//
//  AudioPlayer.swift
//  F1 Data
//
//  Created by Florian DAVID on 12/09/2024.
//

import SwiftUI
import AVFoundation
import UIKit

struct AudioPlayer: View {
    @State private var player: AVPlayer
    @State private var isPlaying = false
    @State private var currentTime: Double = 0.0
    @State private var duration: Double = 1.0
    @State private var timeObserverToken: Any?

    init(url: URL) {
        self.player = AVPlayer(url: url)
    }
    
    var body: some View {
        HStack {
            Button {
                if isPlaying {
                    self.player.pause()
                    self.isPlaying = false
                } else {
                    self.player.play()
                    self.isPlaying = true
                    self.addPeriodicTimeObserver()
                }
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.title)
            }
            
            Slider(value: $currentTime, in: 0...duration, onEditingChanged: { editing in
                if !editing {
                    let seekTime = CMTime(seconds: currentTime, preferredTimescale: 600)
                    player.seek(to: seekTime)
                }
            })
            .padding()
        }
        .padding()
        .onAppear {
            self.addEndOfPlaybackObserver()
        }
        .onDisappear {
            self.removePeriodicTimeObserver()
            self.removeEndOfPlaybackObserver()
        }
    }
    
    // Ajout d'un observateur périodique pour mettre à jour la barre de progression
    private func addPeriodicTimeObserver() {
        let interval = CMTime(seconds: 1, preferredTimescale: 600)
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            let timeElapsed = CMTimeGetSeconds(time)
            self.currentTime = timeElapsed
            
            Task {
                if let duration = try await player.currentItem?.asset.load(.duration) {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.duration = durationSeconds
                }
            }
        }
    }
    
    // Retirer l'observateur lors de la fin de vue
    private func removePeriodicTimeObserver() {
        if let token = timeObserverToken {
            player.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
    
    // Ajout de l'observateur pour détecter la fin de la lecture
    private func addEndOfPlaybackObserver() {
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main) { _ in
                // Réinitialiser le curseur et mettre en pause
                self.player.seek(to: .zero)
                self.currentTime = 0.0
                self.isPlaying = false
            }
    }
    
    // Retirer l'observateur à la fin de la vue
    private func removeEndOfPlaybackObserver() {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
}

#Preview {
    AudioPlayer(url: URL(string: "https://livetiming.formula1.com/static/2023/2023-05-28_Monaco_Grand_Prix/2023-05-28_Race/TeamRadio/ESTOCO01_31_20230528_160937.mp3")!)
}
