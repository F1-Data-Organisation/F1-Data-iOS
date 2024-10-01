//
//  SessionUnfoldingView.swift
//  F1 Data
//
//  Created by Florian DAVID on 13/09/2024.
//

import SwiftUI

struct SessionUnfoldingView: View {
    @StateObject var raceControlVM = RaceControlViewModel()
    @State var session: Int
    
    var body: some View {
        VStack {
            switch raceControlVM.state {
                case .notAvailable:
                    Text("Not available")
                case .loading:
                    ProgressView()
                case .success(let data):
                    if let unfolding = data as? [RaceUnfolding] {
                        ScrollView {
                            ForEach(unfolding, id: \.self.date) { unf in
                                switch unf.item {
                                    case .race_control(let rc):
                                        RaceControlView(control: rc)
                                            .padding(.leading, 5)
                                            .padding(.trailing, 40)
                                    
                                    case .team_radio(let tr):
                                        AudioPlayerView(radio: tr, session: session)
                                            .padding(.leading, 40)
                                            .padding(.trailing, 5)
                                }
                            }
                        }
                    }
                case .failed(error: let error):
                    ErrorView(error: error)
            }
        }
        .task {
            await raceControlVM.getSessionUnfolding(session: session)
        }
    }
}

#Preview {
    SessionUnfoldingView(session: 9094)
}
