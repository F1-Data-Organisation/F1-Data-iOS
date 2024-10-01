//
//  RaceUnfolding.swift
//  F1 Data
//
//  Created by Florian DAVID on 13/09/2024.
//

import Foundation

struct RaceUnfolding: Codable {
    let date: String
    let item: UnfoldingType
    
    enum UnfoldingType: Codable {
        case race_control(RaceControl)
        case team_radio(TeamRadio)
    }
}

struct RaceControl: Codable {
    let date: String
    let lap_number: Int?
    let category: String
    let flag: String?
    let scope: String?
    let sector: Int?
    let message: String
    let driver_number: Int?
}
