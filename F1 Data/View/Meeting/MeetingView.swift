//
//  MeetingView.swift
//  F1 Data
//
//  Created by Florian DAVID on 10/09/2024.
//

import SwiftUI

struct MeetingView: View {
    @StateObject var meetingVM = MeetingViewModel()
    @State var meeting: Meeting
    @State private var firstLoad = true
    
    var body: some View {
        VStack {
            HStack {
                CountryFlag(code: meeting.country_name, width: 75)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(meeting.name)
                        .F1Bold(size: 24)
                    
                    Text(meeting.location)
                        .F1Regular(size: 18)
                }
            }
            
            Text("\(meeting.date_start.toDate(withHours: false)) - \(meeting.date_end.toDate(withHours: false))")
                .F1Regular(size: 18)

            Divider()
                .padding(.vertical)
            
            switch meetingVM.state {
                case .loading: ProgressView()
                case .failed(error: let error): ErrorView(error: error)
                case .success(data: let data):
                    if let sessions = data as? [Session] {
                        NavigationView {
                            List {
                                ForEach(sessions.indices, id: \.self) { i in
                                    let session = sessions[i]
                                    NavigationLink(destination: SessionView(session: session)) {
                                        Text("\(session.name) (\(session.date_start.toDate(withHours: true)))")
                                            .F1Bold(size: 16)
                                    }
                                    .onAppear {
                                        firstLoad = false
                                    }
                                    .entrance(from: .top, itemShow: !firstLoad, delay: Double(i) * 0.5)
                                }
                            }
                            .listStyle(.plain)
                        }
                    }
                default: Text("Sessions not available")
            }
            
            Spacer()
        }
        .task {
            await meetingVM.getAllSessionsFromMeeting(key: meeting.key)
        }
    }
}
