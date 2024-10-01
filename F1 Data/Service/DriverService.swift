//
//  DriverService.swift
//  F1 Data
//
//  Created by Florian DAVID on 08/09/2024.
//

import Foundation

class DriverService {
    func fetchAllDriver(session: Int?) async throws -> [Driver] {
        var queries: [URLQueryItem] = []
        if let num = session {
            queries.append(URLQueryItem(name: "session", value: "\(num)"))
        }
        
        return try await RequestWS.decodeAPIInfo(route: "drivers", queryItems: queries, to: [Driver].self)
    }
    
    func fetchDriverByNumber(driver: Int, session: Int?) async throws -> Driver {
        var queries: [URLQueryItem] = []
        if let num = session {
            queries.append(URLQueryItem(name: "session", value: "\(num)"))
        }
        
        return try await RequestWS.decodeAPIInfo(route: "drivers/by-number/\(driver)", queryItems: queries, to: Driver.self)
    }
    
    func findDriverRacePace(session: Int, driver: Int) async throws -> [LapData] {
        return try await RequestWS.decodeAPIInfo(route: "drivers/race-pace-session/\(session)/\(driver)", queryItems: [], to: [LapData].self)
    }
}
