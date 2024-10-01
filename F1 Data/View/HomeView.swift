//
//  HomeView.swift
//  F1 Data
//
//  Created by Florian DAVID on 10/09/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            VStack(spacing: 25) {
                Image("F1")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.accentColor)
                    .frame(height: 70)
                    .padding()

                Text("intro-home")
                    .F1Regular(size: 20)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
            
            Spacer()
            Image("home-bg")
                .resizable()
                .scaledToFit()
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    HomeView()
}
