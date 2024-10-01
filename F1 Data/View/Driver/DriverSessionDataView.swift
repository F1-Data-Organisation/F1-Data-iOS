//
//  DriverSessionDataView.swift
//  F1 Data
//
//  Created by Florian DAVID on 07/09/2024.
//

import SwiftUI

struct DriverSessionDataView: View {
    @EnvironmentObject var appVM: AppViewModel
    @State var driver: Driver
    @State var session: Session
    @State private var selectedDataType = "lap_times"
    @State private var showRadios = false
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                AsyncImage(url: driver.headshot_url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .background(Color(hex: driver.team_colour ?? ""))
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(driver.full_name)
                        .F1Bold(size: 24)
                    
                    if let team = driver.team_name {
                        Text(team)
                            .F1Regular(size: 16)
                    }
                }
            }

            Divider()
                .padding(.vertical)

            List {
                if session.name == "Race" {
                    Button {
                        appVM.setViewAlert(view:
                            StintsDriverRaceView(driver_number: driver.driver_number, session_key: session.key)
                        )
                    } label: {
                        Text("Stints")
                            .F1Bold(size: 16)
                    }
                }
                
                Button {
                    appVM.setViewAlert(view: RacePaceGraph(driver: driver, session: session))
                } label: {
                    Text("Race pace")
                        .F1Bold(size: 16)
                }
                
                DisclosureGroup(isExpanded: $showRadios) {
                    ListDriverRadiosView(session_id: session.key, driver: driver)
                } label: {
                    Text("Team radios")
                        .F1Bold(size: 16)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("\(driver.full_name) - \(session.name)")
    }
}

#Preview {
    DriverSessionDataView(driver: Driver(driver_number: 31, full_name: "Esteban OCON", name_acronym: "OCO", team_name: "Alpine", team_colour: "2293D1", headshot_url: URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/E/ESTOCO01_Esteban_Ocon/estoco01.png.transform/1col/image.png")!, country_code: "FRA"),
    session: Session(key: 9094, name: "Race", type: "Race", date_start: "2024-05-24T13:00:00.000Z", date_end: "2024-05-24T15:00:00.000Z"))
    .environmentObject(AppViewModel())
}
