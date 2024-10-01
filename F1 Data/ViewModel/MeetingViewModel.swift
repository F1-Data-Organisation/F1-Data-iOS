//
//  MeetingViewModel.swift
//  F1 Data
//
//  Created by Florian DAVID on 08/09/2024.
//

import Foundation

enum MeetingState {
    case notAvailable
    case loading
    case success(data: Codable? = nil)
    case failed(error: Error)
}

@MainActor
class MeetingViewModel: ObservableObject {
    @Published var state: MeetingState = .notAvailable
    private let service: MeetingService
    
    init() {
        self.service = MeetingService()
    }
    
    func getAllSeasonMeetings() async {
        self.state = .loading
        
        do {
            let all = try await service.fetchAllMeetings()
            self.state = .success(data: all)
        } catch {
            self.state = .failed(error: error)
            print(error.localizedDescription)
        }
    }
    
    func getMeetingByKey(key: Int) async {
        self.state = .loading
        
        do {
            let meeting = try await service.fetchMeetingByKey(key: key)
            self.state = .success(data: meeting)
        } catch {
            self.state = .failed(error: error)
            print(error.localizedDescription)
        }
    }
    
    func getAllSessionsFromMeeting(key: Int) async {
        self.state = .loading
        
        do {
            let sessions = try await service.fetchSessionsByMeeting(key: key)
            self.state = .success(data: sessions)
        } catch {
            self.state = .failed(error: error)
            print(error.localizedDescription)
        }
    }
    
    func getSessionByKey(key: Int) async {
        self.state = .loading
        
        do {
            let session = try await service.fetchSessionByKey(key: key)
            self.state = .success(data: session)
        } catch {
            self.state = .failed(error: error)
            print(error.localizedDescription)
        }
    }
    
    func getClassification(session_key: Int) async {
        self.state = .loading
        
        do {
            let classification = try await service.fetchSessionClassification(key: session_key)
            self.state = .success(data: classification)
        } catch {
            self.state = .failed(error: error)
            print(error.localizedDescription)
        }
    }
    
    func getFastestLap(session_key: Int) async -> LapData? {
        do {
            let lap = try await service.fetchFastestLap(session: session_key)
            return lap
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
