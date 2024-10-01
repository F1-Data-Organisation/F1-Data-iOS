//
//  MeetingsListView.swift
//  F1 Data
//
//  Created by Florian DAVID on 08/09/2024.
//

import SwiftUI

struct MeetingsListView: View {
    @StateObject var meetingVM = MeetingViewModel()
    @State private var firstLoad = true
    
    var body: some View {
        VStack {
            switch meetingVM.state {
                case .notAvailable: EmptyView()
                case .loading: ProgressView()
                case .failed(error: let error): ErrorView(error: error)
                case .success(data: let data):
                    if let meetings = data as? [Meeting] {
                        List {
                            ForEach(meetings.indices, id: \.self) { i in
                                let meeting = meetings[i]
                                let destination = MeetingView(meeting: meeting)
                                    .navigationTitle("Round \(i+1) - \(meeting.location)")
                                
                                NavigationLink(destination: destination) {
                                    HStack(spacing: 10) {
                                        Text(String().appendingFormat("%02d", i+1))
                                            .F1Bold(size: 24)
                                            .frame(width: 40)
                                        
                                        CountryFlag(code: meeting.country_name, width: 30)

                                        VStack(alignment: .leading) {
                                            Text(meeting.name)
                                                .F1Bold(size: 20)
                                            
                                            Text(meeting.location)
                                                .F1Regular(size: 16)
                                        }
                                    }
                                }
                                .onAppear(perform: {
                                    firstLoad = false
                                })
                                .entrance(from: .right, itemShow: !firstLoad, delay: Double(i) * 0.5)
                            }
                        }
                        .listStyle(.plain)
                    }
            }
        }
        .task {
            if firstLoad {
                await meetingVM.getAllSeasonMeetings()
            }
        }
    }
}

#Preview {
    MeetingsListView()
}
