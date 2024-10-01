//
//  StintTyresView.swift
//  F1 Data
//
//  Created by Florian DAVID on 05/09/2024.
//

import SwiftUI

struct StintTyresView: View {
    private let tyres = ["hard", "medium", "soft", "intermediate", "wet"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(tyres, id: \.self) { tyre in
                HStack {
                    Image("f1-\(tyre)-tyre")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70)
                    
                    Text(tyre.uppercased())
                        .F1Regular(size: 16)
                        .foregroundColor(Color("f1-\(tyre)-tyre-color"))
                }
            }
            
            VStack(spacing: 10) {
                RectangleLegend(color: .gray, hached: false, text: "New tyre")
                RectangleLegend(color: .gray, hached: true, text: "Used tyre")
            }
        }
    }
}

private struct RectangleLegend: View {
    @State var color: Color
    @State var hached: Bool
    @State var text: String

    var body: some View {
        HStack {
            Group {
                if hached {
                    Rectangle()
                        .hached(
                            foreground: color,
                            lineWidth: 4
                        )
                        .clipped()
                } else {
                    Rectangle()
                        .fill(color)
                }
            }
            .frame(width: 60, height: 30)
            
            Text(LocalizedStringKey(text))
                .F1Regular(size: 18)
                .foregroundColor(color)
        }
    }
}

#Preview {
    StintTyresView()
}
