//
//  ListDriverRadiosView.swift
//  F1 Data
//
//  Created by Florian DAVID on 07/09/2024.
//

import SwiftUI

struct ListDriverRadiosView: View {
    @StateObject var raceControlVM = RaceControlViewModel()
    @State var session_id: Int
    @State var driver: Driver
    
    var body: some View {
        VStack {
            switch raceControlVM.state {
                case .loading: ProgressView()
                case .success(data: let data):
                    if let teamRadios = data as? [TeamRadio] {
                        ScrollView {
                            ForEach(teamRadios, id: \.self.date) { tr in
                                AudioPlayerView(radio: tr, session: session_id)
                                    .padding()
                            }
                        }
                    }
                
                case .failed(error: let error): ErrorView(error: error)
                default: EmptyView()
            }
        }
        .task {
            await raceControlVM.getAllTeamRadiosFrom(session: session_id, driver: driver.driver_number)
        }
    }
}

#Preview {
    ListDriverRadiosView(session_id: 9094, driver: Driver(driver_number: 31, full_name: "Esteban OCON", name_acronym: "OCO", team_name: "Alpine", team_colour: "2293D1", headshot_url: URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/E/ESTOCO01_Esteban_Ocon/estoco01.png.transform/1col/image.png")!, country_code: "FRA"))
}
