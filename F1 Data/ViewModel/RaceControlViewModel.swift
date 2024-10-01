//
//  RaceControlViewModel.swift
//  F1 Data
//
//  Created by Florian DAVID on 07/09/2024.
//

import Foundation

enum RaceControlState {
    case notAvailable
    case loading
    case success(data: Codable? = nil)
    case failed(error: Error)
}

@MainActor
class RaceControlViewModel: ObservableObject {
    @Published var state: RaceControlState = .notAvailable
    private let service: RaceControlService
    
    init() {
        self.service = RaceControlService()
    }
    
    func getAllTeamRadiosFrom(session: Int, driver: Int?) async {
        self.state = .loading
        
        do {
            let teams = try await service.fetchAllTeamRadiosFromSession(session: session, driver: driver)
            self.state = .success(data: teams)
        } catch {
            self.state = .failed(error: error)
            print(error.localizedDescription)
        }
    }
    
    func getAllControlsFrom(session: Int) async {
        self.state = .loading
        
        do {
            let controls = try await service.fetchAllControlsInSession(session: session)
            self.state = .success(data: controls)
        } catch {
            self.state = .failed(error: error)
            print(error.localizedDescription)
        }
    }
    
    func getSessionUnfolding(session: Int) async {
        self.state = .loading
        
        do {
            let controls = try await service.fetchAllControlsInSession(session: session)
            let radios = try await service.fetchAllTeamRadiosFromSession(session: session, driver: nil)
            //print(controls, radios)
            let combinedItems: [RaceUnfolding] = (controls.map { RaceUnfolding(date: $0.date, item: .race_control($0)) } +
                                                 radios.map { RaceUnfolding(date: $0.date, item: .team_radio($0)) })
                                                 .sorted(by: { $0.date < $1.date })
            
            self.state = .success(data: combinedItems)
        } catch {
            self.state = .failed(error: error)
            print(error.localizedDescription)
        }
    }
}
