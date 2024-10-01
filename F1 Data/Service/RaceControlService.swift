//
//  RaceControlService.swift
//  F1 Data
//
//  Created by Florian DAVID on 07/09/2024.
//

import Foundation

class RaceControlService {
    func fetchAllTeamRadiosFromSession(session: Int, driver: Int?) async throws -> [TeamRadio] {
        var queries: [URLQueryItem] = []
        if let num = driver {
            queries.append(URLQueryItem(name: "driver", value: "\(num)"))
        }
        
        return try await RequestWS.decodeAPIInfo(route: "race-control/team-radios/session/\(session)", queryItems: queries, to: [TeamRadio].self)
    }
    
    func fetchAllControlsInSession(session: Int) async throws -> [RaceControl] {
        return try await RequestWS.decodeAPIInfo(route: "race-control/controls/session/\(session)", queryItems: [], to: [RaceControl].self)
    }
}
