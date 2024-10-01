//
//  MoreAppsView.swift
//  F1 Data
//
//  Created by Florian DAVID on 09/09/2024.
//

import SwiftUI

struct MoreAppsView: View {
    @State private var showItems = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("+appsF1")
                .F1Bold(size: 20)
                .zoom(itemShow: showItems)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    F1AppItemView(appId: "835022598", appName: "Formula 1®")
                    F1AppItemView(appId: "1315007279", appName: "F1 TV")
                    F1AppItemView(appId: "1332717455", appName: "F1 Race Guide")
                    F1AppItemView(appId: "1455108472", appName: "F1® Play")
                }
                .furtive(from: .right, itemShow: showItems, delay: 0.5)
            }
            .padding(.bottom, 25)
            
            Text("+worldF1")
                .F1Bold(size: 20)
                .zoom(itemShow: showItems, delay: 1.5)

            ScrollView {
                F1PartItemView(itemName: "Authentics", itemURL: "https://www.f1authentics.com/")
                    .entrance(from: .right, itemShow: showItems, delay: 2)
                
                F1PartItemView(itemName: "Experiences", itemURL: "https://f1experiences.com/")
                    .entrance(from: .right, itemShow: showItems, delay: 2.5)
                
                F1PartItemView(itemName: "Esports", itemURL: "https://f1esports.com/")
                    .entrance(from: .right, itemShow: showItems, delay: 3)
                
                F1PartItemView(itemName: "Hospitality", itemURL: "https://tickets.formula1.com/h-formula1-hospitality")
                    .entrance(from: .right, itemShow: showItems, delay: 3.5)
                
                F1PartItemView(itemName: "Store", itemURL: "https://f1store2.formula1.com/")
                    .entrance(from: .right, itemShow: showItems, delay: 4)
                
                F1PartItemView(itemName: "Tickets", itemURL: "https://tickets.formula1.com/")
                    .entrance(from: .right, itemShow: showItems, delay: 4.5)
            }
        }
        .padding()
        .navigationTitle("+contentF1")
        .onAppear {
            withAnimation {
                showItems = true
            }
        }
    }
}

private struct F1PartItemView: View {
    @State var itemName: String
    @State var itemURL: String
    
    var body: some View {
        Button {
            if let url = URL(string: itemURL) {
                UIApplication.shared.open(url)
            } else {
                print("Invalid URL : \(itemURL)")
            }
        } label: {
            HStack(alignment: .center) {
                Image("F1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75)
                
                Text(itemName)
                    .F1Bold(size: 24)
                    .foregroundColor(.primary)
                
                Spacer()
                Image(systemName: "arrowshape.turn.up.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
            }
            .padding()
            .background(.gray.opacity(0.5))
            .cornerRadius(10)
        }
    }
}

private struct F1AppItemView: View {
    @State var appId: String
    @State var appName: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image("\(appId)-logo")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .cornerRadius(20)
            
            Text(appName)
                .F1Bold(size: 20)
                .foregroundColor(.primary)
                .padding(.bottom, 10)
            
            Button {
                UIApplication.shared.open(URL(string: "https://apps.apple.com/app/id\(appId)")!)
            } label: {
                let lang = Locale.preferredLanguages.first ?? "en"
                Image("DownloadAppStore_\(lang.prefix(2).uppercased())")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
            }
        }
        .frame(width: 200, height: 200)
        .background(.gray.opacity(0.5))
        .cornerRadius(10)
    }
}

#Preview {
    MoreAppsView()
}
