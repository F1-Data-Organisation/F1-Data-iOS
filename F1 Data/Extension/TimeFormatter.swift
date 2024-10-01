//
//  TimeFormatter.swift
//  F1 Data
//
//  Created by Florian DAVID on 16/09/2024.
//

import Foundation

extension Double {
    func toTime() -> String {
        let total = Int(self * 1000)
        
        let hours = total / 3600000
        let minutes = (total % 3600000) / 60000
        let seconds = (total % 60000) / 1000
        let milliseconds = total % 1000

        if hours > 0 {
            return String(format: "%2d:%02d:%02d.%03d", hours, minutes, seconds, milliseconds)
        } else if minutes > 0 {
            return String(format: "%2d:%02d.%03d", minutes, seconds, milliseconds)
        } else {
            return String(format: "%02d.%03d", seconds, milliseconds)
        }
    }
}
