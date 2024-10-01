//
//  MeetingService.swift
//  F1 Data
//
//  Created by Florian DAVID on 08/09/2024.
//

import Foundation

class MeetingService {
    func fetchAllMeetings() async throws -> [Meeting] {
        return try await RequestWS.decodeAPIInfo(route: "meetings", queryItems: [], to: [Meeting].self)
    }
    
    func fetchMeetingByKey(key: Int) async throws -> Meeting {
        return try await RequestWS.decodeAPIInfo(route: "meetings/by-key/\(key)", queryItems: [], to: Meeting.self)
    }
    
    func fetchSessionsByMeeting(key: Int) async throws -> [Session] {
        return try await RequestWS.decodeAPIInfo(route: "meetings/sessions/mt-key/\(key)", queryItems: [], to: [Session].self)
    }
    
    func fetchSessionByKey(key: Int) async throws -> Session {
        return try await RequestWS.decodeAPIInfo(route: "meetings/sessions/se-key/\(key)", queryItems: [], to: Session.self)
    }
    
    func fetchSessionClassification(key: Int) async throws -> [Driver] {
        return try await RequestWS.decodeAPIInfo(route: "meetings/session-classification/\(key)", queryItems: [], to: [Driver].self)
    }
    
    func fetchFastestLap(session: Int) async throws -> LapData {
        return try await RequestWS.decodeAPIInfo(route: "meetings/sessions/fastest-lap/\(session)", queryItems: [], to: LapData.self)
    }
}
