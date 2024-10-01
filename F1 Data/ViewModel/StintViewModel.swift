//
//  StintViewModel.swift
//  F1 Data
//
//  Created by Florian DAVID on 12/09/2024.
//

import Foundation

enum StintState {
    case notAvailable
    case loading
    case success(data: Codable? = nil)
    case failed(error: Error)
}

@MainActor
class StintViewModel: ObservableObject {
    @Published var state: StintState = .notAvailable
    private let service: StintService
    
    init() {
        self.service = StintService()
    }
    
    func getAllStintsFromDriverAndSession(session: Int, driver: Int) async {
        self.state = .loading
        
        do {
            let teams = try await service.fetchStintsDriverInSession(driver: driver, session: session)
            self.state = .success(data: teams)
        } catch {
            self.state = .failed(error: error)
            print(error.localizedDescription)
        }
    }
}
