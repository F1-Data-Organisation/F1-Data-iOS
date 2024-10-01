//
//  ColorExtension.swift
//  F1FansApp
//
//  Created by Florian DAVID on 21/08/2024.
//

import SwiftUI

extension Color {
    init(hex: String?) {
        if let hex = hex {
            var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
            var rgb: UInt64 = 0
            
            Scanner(string: cleanHexCode).scanHexInt64(&rgb)
            
            let redValue = Double((rgb >> 16) & 0xFF) / 255.0
            let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
            let blueValue = Double(rgb & 0xFF) / 255.0
            self.init(red: redValue, green: greenValue, blue: blueValue)
        } else {
            self.init(uiColor: UIColor(Color.accentColor))
        }
    }
    
    func constrasting() -> Color {
        if self == .primary {
            let style = UITraitCollection.current.userInterfaceStyle
            return style == .dark ? Color.black : Color.white
        } else {
            let uiColor = UIColor(self)
            let ciColor = CIColor(color: uiColor)
            
            let r = ciColor.red
            let g = ciColor.green
            let b = ciColor.blue
            
            let luminance = 0.299 * r + 0.587 * g + 0.114 * b
            return luminance > 0.5 ? Color.black : Color.white
        }
    }
}
