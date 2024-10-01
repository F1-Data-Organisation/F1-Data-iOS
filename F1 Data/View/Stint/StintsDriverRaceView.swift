//
//  StintsDriverRaceView.swift
//  F1 Data
//
//  Created by Florian DAVID on 05/09/2024.
//

import SwiftUI

struct StintsDriverRaceView: View {
    @StateObject var stintVM = StintViewModel()
    @State private var firstLoad = true
    @State var driver_number: Int
    @State var session_key: Int
    
    var body: some View {
        VStack {
            switch stintVM.state {
            case .notAvailable:
                Text("No stints available")
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error)
            case .success(let data):
                if let stints = data as? [Stint] {
                    HStack(spacing: 40) {
                        VStack {
                            let nbLaps = stints.map { $0.lap_end - $0.lap_start + 1 }.reduce(0, +)

                            VStack(spacing: 0) {
                                ForEach(stints, id: \.self.stint_number) { stint in
                                    StintItemView(stint: stint, 
                                                  height: getHeightStint(stint: stint, laps: nbLaps))
                                }
                            }
                            
                            Text("\(nbLaps)")
                        }
                        .F1Bold(size: 16)
                        
                        StintTyresView()
                    }
                }
            }
        }
        .task {
            if firstLoad {
                firstLoad = false
                await stintVM.getAllStintsFromDriverAndSession(session: session_key, driver: driver_number)
            }
        }
    }
    
    func getHeightStint(stint: Stint, laps: Int) -> CGFloat {
        let nbLaps = stint.lap_end - stint.lap_start + 1
        let ratio = CGFloat(nbLaps) / CGFloat(laps)
        let height = (UIScreen.main.bounds.height - 400) * ratio
        return height > 40 ? height : 40
    }
}

#Preview {
    StintsDriverRaceView(driver_number: 31, session_key: 9094)
}
