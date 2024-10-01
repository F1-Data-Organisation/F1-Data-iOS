//
//  HachedExtension.swift
//  F1 Data
//
//  Created by Florian DAVID on 05/09/2024.
//

import SwiftUI

extension Shape {
    func hached(foreground: Color, lineWidth: Double) -> some View {
        self.fill(.clear)
            .overlay(
                HatchedPattern()
                    .stroke(foreground, lineWidth: CGFloat(lineWidth))
            )
    }
}

private struct HatchedPattern: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let spacing: CGFloat = 10
        let angle: CGFloat = .pi / 4

        for i in stride(from: -rect.height, to: rect.width, by: spacing) {
            let startX = i
            let startY: CGFloat = 0
            let endX = i + rect.height * tan(angle)
            let endY = rect.height
            
            path.move(to: CGPoint(x: startX, y: startY))
            path.addLine(to: CGPoint(x: endX, y: endY))
        }

        return path
    }
}
