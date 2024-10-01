//
//  F1_DataApp.swift
//  F1 Data
//
//  Created by Florian DAVID on 04/09/2024.
//

import SwiftUI

@main
struct F1_DataApp: App {
    init() {
        setFontsForBars()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppViewModel())
        }
    }
    
    func setFontsForBars() {
        let attributesBold: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Formula1-Display-Bold", size: 18)!,
            .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle,
        ]
        
        let attributesReg: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Formula1-Display-Regular", size: 14)!,
            .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(attributesReg, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(attributesReg, for: .normal)
        UINavigationBar.appearance().titleTextAttributes = attributesBold
        
        UISegmentedControl.appearance().setTitleTextAttributes(attributesReg, for: .normal)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.gray)
    }
}
