//
//  SessionCltView.swift
//  F1 Data
//
//  Created by Florian DAVID on 12/09/2024.
//

import SwiftUI

struct SessionCltView: View {
    @StateObject var meetingVM = MeetingViewModel()
    @State private var bestLap: LapData? = nil
    @State private var firstLoad = true
    @State var session: Session
    
    var body: some View {
        VStack {
            switch meetingVM.state {
                case .notAvailable:
                    Text("Standings not available")
                case .loading:
                    ProgressView()
                case .success(let data):
                    if let drivers = data as? [Driver] {
                        if session.type != "Practice" {
                            Text("Classification (chequered flag)")
                                .F1Bold(size: 20)
                                .multilineTextAlignment(.center)
                        }
                        List {
                            ForEach(drivers.indices, id: \.self) { i in
                                let driver = drivers[i]
                                HStack {
                                    Text(String().appendingFormat("%02d", i + 1))
                                        .F1Bold(size: 26)
                                        .frame(width: 50)
                                    
                                    NavigationLink(destination: DriverSessionDataView(driver: driver, session: session)) {
                                        DriverListItem(driver: driver)
                                            .foregroundColor(bestLap?.driver?.driver_number == drivers[i].driver_number ? .purple : .primary)
                                    }
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                case .failed(let error):
                    ErrorView(error: error)
            }
        }
        .task {
            if firstLoad {
                firstLoad = false
                await meetingVM.getClassification(session_key: session.key)
            }
        }
        .onAppear(perform: {
            Task {
                bestLap = await meetingVM.getFastestLap(session_key: session.key)
            }
        })
    }
}

#Preview {
    SessionCltView(session: Session(key: 9165, name: "Qualifying", type: "Qualifying", date_start: "2023-05-27T14:00:00.000Z", date_end: "2023-05-27T15:00:00.000Z"))
}
