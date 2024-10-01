//
//  AnimationExtension.swift
//  F1 Data
//
//  Created by Florian DAVID on 26/09/2024.
//

import SwiftUI

enum AnimPosition: String, CaseIterable {
    case left, right, top, bottom
}

extension View {
    func entrance(from: AnimPosition, itemShow: Bool, duration: Double = 1.0, delay: Double = 0.0) -> some View {
        return Group {
            switch from {
                case .left: self.offset(x: itemShow ? 0 : -UIScreen.main.bounds.width)
                case .right: self.offset(x: itemShow ? 0 : UIScreen.main.bounds.width)
                case .top: self.offset(y: itemShow ? 0 : -UIScreen.main.bounds.height)
                case .bottom: self.offset(y: itemShow ? 0 : UIScreen.main.bounds.height)
            }
        }
        .animation(.spring(response: duration).delay(delay), value: itemShow)
    }
    
    func furtive(from: AnimPosition, itemShow: Bool, duration: Double = 1.0, delay: Double = 0.0) -> some View {
        return Group {
            switch from {
                case .left: self.offset(x: itemShow ? 0 : -UIScreen.main.bounds.width)
                case .right: self.offset(x: itemShow ? 0 : UIScreen.main.bounds.width)
                case .top: self.offset(y: itemShow ? 0 : -UIScreen.main.bounds.height)
                case .bottom: self.offset(y: itemShow ? 0 : UIScreen.main.bounds.height)
            }
        }
        .animation(.easeOut(duration: duration).delay(delay), value: itemShow)
    }
    
    func zoom(itemShow: Bool, duration: Double = 1.0, delay: Double = 0.0) -> some View {
        return self.scaleEffect(itemShow ? 1.0 : 0.0)
            .animation(.easeOut(duration: duration).delay(delay), value: itemShow)
    }
    
    func fade(itemShow: Bool, delay: Double = 0.0) -> some View {
        return self.opacity(itemShow ? 1 : 0)
            .animation(.easeOut(duration: 1.0).delay(delay), value: itemShow)
    }
}
