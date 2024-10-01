//
//  LapData.swift
//  F1 Data
//
//  Created by Florian DAVID on 16/09/2024.
//

import Foundation

struct LapData: Codable {
    let driver: Driver?
    let lap_number: Int
    let date: String
    let duration: Double
    let is_pit_out_lap: Bool
    let sector_1: Double
    let sector_2: Double
    let sector_3: Double
}
