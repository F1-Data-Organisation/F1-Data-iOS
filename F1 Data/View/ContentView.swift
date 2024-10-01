//
//  ContentView.swift
//  F1 Data
//
//  Created by Florian DAVID on 04/09/2024.
//

import SwiftUI
import Charts

struct ContentView: View {
    @EnvironmentObject var appVM: AppViewModel
    var body: some View {
        NavigationView {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("title-home")
                    }
                
                MeetingsListView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("title-list")
                    }
            }
            .navigationBarTitle("F1 Data", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: MoreAppsView()) {
                        Image(systemName: "square.grid.2x2.fill")
                    }
            )
        }
        .subAlert(isPresented: $appVM.subAlertPresent, action: {}) {
            appVM.subAlertView
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppViewModel())
}
