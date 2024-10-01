//
//  DriverViewModel.swift
//  F1 Data
//
//  Created by Florian DAVID on 08/09/2024.
//

import Foundation

enum DriverState {
    case notAvailable
    case loading
    case success(data: Codable? = nil)
    case failed(error: Error)
}

@MainActor
class DriverViewModel: ObservableObject {
    @Published var state: DriverState = .notAvailable
    private let service: DriverService
    
    init() {
        self.service = DriverService()
    }
    
    func getAllDrivers(session: Int?) async {
        self.state = .loading
        
        do {
            let all = try await service.fetchAllDriver(session: session)
            self.state = .success(data: all)
        } catch {
            self.state = .failed(error: error)
            print(error.localizedDescription)
        }
    }
    
    func getDriverByNumber(driver: Int, session: Int?) async {
        self.state = .loading
        
        do {
            let driver = try await service.fetchDriverByNumber(driver: driver, session: session)
            self.state = .success(data: driver)
        } catch {
            self.state = .failed(error: error)
            print(error.localizedDescription)
        }
    }
    
    func getDriverRacePace(session: Int, driver: Int) async {
        self.state = .loading
        
        do {
            let pace = try await service.findDriverRacePace(session: session, driver: driver)
            self.state = .success(data: pace)
        } catch {
            self.state = .failed(error: error)
            print(error.localizedDescription)
        }
    }
}
