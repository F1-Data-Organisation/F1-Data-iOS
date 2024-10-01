//
//  ControlFlagGenerator.swift
//  F1 Data
//
//  Created by Florian DAVID on 13/09/2024.
//

import SwiftUI

struct ControlFlagGenerator: View {
    @State var flag_name: String
    @State var number: String
    
    init(flag: String, number: Int?) {
        self.flag_name = "\(flag.replacingOccurrences(of: " ", with: "-").lowercased())-flag"
        if let nb = number {
            self.number = "\(nb)"
        } else {
            self.number = ""
        }
    }
    
    var body: some View {
        ZStack {
            Group {
                if let color = UIColor(named: flag_name) {
                    Color(uiColor: color)
                } else if let image = UIImage(named: flag_name) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    EmptyView()
                }
            }
            
            Text(number)
                .font(.system(size: 24))
                .foregroundColor(Color.blue)
                .bold()
        }
        .frame(width: 50, height: 50)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color(.systemGray5), lineWidth: 5))
    }
}

#Preview {
    ControlFlagGenerator(flag: "BLUE", number: 14)
}
