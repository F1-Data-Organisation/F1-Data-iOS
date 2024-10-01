//
//  AlertExtension.swift
//  F1 Data
//
//  Created by Florian DAVID on 01/10/2024.
//

import SwiftUI

extension View {
    func subAlert<C: View>(isPresented: Binding<Bool>, action: @escaping () -> Void, content: @escaping () -> C) -> some View {
        ZStack {
            self.blur(radius: isPresented.wrappedValue ? 1 : 0)
            
            if isPresented.wrappedValue {
                SubViewAlert(action: {
                    withAnimation {
                        action()
                        isPresented.wrappedValue = false
                    }
                }, content: content)
                .fade(itemShow: isPresented.wrappedValue)
            }
        }
    }
}
