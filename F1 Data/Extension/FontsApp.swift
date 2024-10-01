//
//  FontsApp.swift
//  F1FansApp
//
//  Created by Florian DAVID on 14/08/2024.
//

import SwiftUI

extension View {
    func F1Bold(size: Int) -> some View {
        self.font(Font.custom("Formula1-Display-Bold", size: CGFloat(size)))
    }
    
    func F1Regular(size: Int) -> some View {
        self.font(Font.custom("Formula1-Display-Regular", size: CGFloat(size)))
    }
}
