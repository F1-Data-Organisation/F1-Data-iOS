//
//  Meeting.swift
//  F1 Data
//
//  Created by Florian DAVID on 08/09/2024.
//

import Foundation

struct Meeting: Codable {
    let key: Int
    let name: String
    let official_name: String
    let code: String
    let circuit_name: String
    let location: String
    let country_code: String
    let country_name: String
    let date_start: String
    let date_end: String
    let year: Int
}

struct Session: Codable {
    let key: Int
    let name: String
    let type: String
    let date_start: String
    let date_end: String
}
