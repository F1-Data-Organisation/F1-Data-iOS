//
//  StintService.swift
//  F1 Data
//
//  Created by Florian DAVID on 07/09/2024.
//

import Foundation

class StintService {
    func fetchStintsDriverInSession(driver: Int, session: Int) async throws -> [Stint] {
        return try await RequestWS.decodeAPIInfo(route: "drivers/session-stints/\(driver)/\(session)", queryItems: [], to: [Stint].self)
    }
}
