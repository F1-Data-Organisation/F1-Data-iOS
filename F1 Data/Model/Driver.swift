//
//  Driver.swift
//  F1 Data
//
//  Created by Florian DAVID on 07/09/2024.
//

import Foundation

struct Driver: Codable {
    let driver_number: Int
    let full_name: String
    let name_acronym: String
    let team_name: String?
    let team_colour: String?
    let headshot_url: URL?
    let country_code: String?
}
