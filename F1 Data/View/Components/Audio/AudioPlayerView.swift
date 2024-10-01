//
//  AudioPlayerView.swift
//  F1 Data
//
//  Created by Florian DAVID on 07/09/2024.
//

import SwiftUI
import AVFoundation
import UIKit

struct AudioPlayerView: View {
    @StateObject var driverVM = DriverViewModel()
    @State var radio: TeamRadio
    @State var session: Int
    
    var body: some View {
        ZStack(alignment: .trailingFirstTextBaseline) {
            let driver = radio.driver
            
            AudioPlayer(url: radio.recording_url)
                .tint(Color(hex: driver.team_colour))
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemGray5))
                )
            
            HStack(spacing: 0) {
                Text("\(driver.name_acronym) - \(radio.date.toDate(withHours: true))")
                    .F1Bold(size: 16)
                    .padding(10)
                    .foregroundColor(Color(hex: driver.team_colour))
                    .background(Color(.systemGray5))
                    .cornerRadius(5)
                
                AsyncImage(url: driver.headshot_url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    EmptyView()
                }
                .frame(width: 50, height: 50)
                .background(Color(hex: driver.team_colour))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.systemGray5), lineWidth: 5))
            }
            .alignmentGuide(.firstTextBaseline) { d in d[.leading] + 50 }
        }
    }
}

#Preview {
    AudioPlayerView(radio: TeamRadio(date: "2023-05-28T14:30:00.000Z", driver: Driver(driver_number: 31, full_name: "Esteban OCON", name_acronym: "OCO", team_name: "Alpine", team_colour: "2293D1", headshot_url: URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/E/ESTOCO01_Esteban_Ocon/estoco01.png.transform/1col/image.png")!, country_code: "FRA"), recording_url: URL(string: "https://livetiming.formula1.com/static/2023/2023-05-28_Monaco_Grand_Prix/2023-05-28_Race/TeamRadio/ESTOCO01_31_20230528_160937.mp3")!), session: 9094)
}
