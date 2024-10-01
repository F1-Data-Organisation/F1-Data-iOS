//
//  RaceControlView.swift
//  F1 Data
//
//  Created by Florian DAVID on 13/09/2024.
//

import SwiftUI

struct RaceControlView: View {
    @State var control: RaceControl
    @State private var bgColor: Color
    
    init(control: RaceControl) {
        self.control = control
        self.bgColor = {
            if let flag = control.flag, let uiColor = UIColor(named: "\(flag.lowercased())-flag") {
                return Color(uiColor: uiColor)
            } else {
                return Color(.systemGray5)
            }
        }()
    }
    
    var body: some View {
        ZStack(alignment: .leadingFirstTextBaseline) {
            Text(control.message)
                .F1Regular(size: 16)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(bgColor)
                .cornerRadius(20)

            HStack {
                HStack(spacing: 0) {
                    Image("fia-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color(.systemGray5), lineWidth: 5))
                    
                    if let flag = control.flag, flag != "CLEAR" {
                        ControlFlagGenerator(flag: flag, number: control.driver_number)
                    }
                }
                
                Text(control.date.toDate(withHours: true))
                    .F1Bold(size: 16)
                    .padding(10)
                    .background(bgColor)
                    .cornerRadius(5)
            }
            .alignmentGuide(.firstTextBaseline) { d in d[.leading] + 70 }
        }
        .foregroundColor(bgColor == Color(.systemGray5) ? .primary : bgColor.constrasting())
    }
}

#Preview {
    RaceControlView(control: RaceControl(date: "2023-05-28T14:30:00.000Z", lap_number: 1, category: "Flag", flag: "YELLOW", scope: "Sector", sector: 9, message: "YELLOW IN TRACK SECTOR 9", driver_number: nil))
}
