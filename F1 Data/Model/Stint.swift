//
//  Stint.swift
//  F1 Data
//
//  Created by Florian DAVID on 05/09/2024.
//

import Foundation

struct Stint: Codable {
    let stint_number: Int
    let lap_start: Int
    let lap_end: Int
    let compound: String
    let tyre_age_at_start: Int
}
