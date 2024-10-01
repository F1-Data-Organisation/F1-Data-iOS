//
//  SessionView.swift
//  F1 Data
//
//  Created by Florian DAVID on 11/09/2024.
//

import SwiftUI

struct SessionView: View {
    @StateObject var meetingVM = MeetingViewModel()
    @State var session: Session
    @State private var catSelect = "Clt"
    
    var body: some View {
        VStack {
            Picker("Category", selection: $catSelect) {
                Text("Classification").tag("Clt")
                Text("Radios & race control").tag("R&RC")
                Text("Weather").tag("Wth")
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            Divider()
                .padding()
                .tint(.gray)

            switch catSelect {
                case "Clt":
                    SessionCltView(session: session)
                case "R&RC":
                    SessionUnfoldingView(session: session.key)
                case "Wth":
                    EmptyView()
                default:
                    EmptyView()
            }
            
            Spacer()
        }
        .navigationTitle(session.name)
    }
}

#Preview {
    SessionView(session: Session(key: 9090, name: "Qualifying", type: "Qualifying", date_start: "2023-05-27T14:00:00.000Z", date_end: "2023-05-27T15:00:00.000Z"))
}
