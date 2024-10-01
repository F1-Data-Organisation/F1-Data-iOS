//
//  StintItemView.swift
//  F1 Data
//
//  Created by Florian DAVID on 05/09/2024.
//

import SwiftUI

struct StintItemView: View {
    @State var stint: Stint
    @State var height: CGFloat
    
    var body: some View {
        ZStack(alignment: .top) {
            Group {
                if stint.tyre_age_at_start > 0 {
                    Rectangle()
                        .hached(
                            foreground: Color("f1-\(stint.compound.lowercased())-tyre-color"),
                            lineWidth: 4
                        )
                        .clipped()
                } else {
                    Rectangle()
                        .fill(Color("f1-\(stint.compound.lowercased())-tyre-color"))
                }
            }
            .frame(width: 30, height: height)
            .border(Color.primary, width: 1)
            
            if stint.lap_start != 1 {
                Text(String().appendingFormat("%02d", stint.lap_start - 1))
                    .foregroundColor(.orange)
                    .padding(10)
                    .background(.primary)
                    .clipShape(Circle())
                    .padding(.top, -18)
            }
        }
    }
}

#Preview {
    StintItemView(stint: Stint(stint_number: 1, lap_start: 1, lap_end: 2, compound: "SOFT", tyre_age_at_start: 0), height: 40)
}
