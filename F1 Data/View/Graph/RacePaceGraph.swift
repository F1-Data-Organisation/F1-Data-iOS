//
//  RacePaceGraph.swift
//  F1 Data
//
//  Created by Florian DAVID on 05/09/2024.
//

import SwiftUI
import Charts

struct RacePaceGraph: View {
    @StateObject var driverVM = DriverViewModel()
    @State var driver: Driver
    @State var session: Session
    
    var body: some View {
        VStack {
            switch driverVM.state {
            case .notAvailable:
                Text("No data for race pace")
            case .loading:
                ProgressView()
            case .success(let data):
                if let pace = data as? [LapData], pace.count > 0 {
                    Chart(pace, id: \.self.date) {
                        LineMark(
                            x: .value("x", $0.lap_number),
                            y: .value("y", max(-$0.duration, -120))
                        )
                        .foregroundStyle(Color(hex: driver.team_colour))
                    }
                    .chartYScale(domain: -120...(-50))
                    .chartYAxis {
                        AxisMarks(position: .leading) { value in
                            AxisGridLine()
                            AxisValueLabel {
                                if let doubleValue = value.as(Double.self) {
                                    Text("\((-doubleValue).toTime())")
                                }
                            }
                        }
                    }
                    .frame(height: 250)
                    
                    let bestLap = pace.sorted(by: { $0.duration < $1.duration })[0]
                    Text("Best lap on \(bestLap.duration.toTime()) (lap \(bestLap.lap_number))")
                        .F1Bold(size: 18)
                        .foregroundColor(.purple)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    Text("No data for race pace in loading")
                }
            case .failed(let error):
                ErrorView(error: error)
            }
        }
        .padding()
        .task {
            await driverVM.getDriverRacePace(session: session.key, driver: driver.driver_number)
        }
    }
}

#Preview {
    RacePaceGraph(driver: Driver(driver_number: 31, full_name: "Esteban OCON", name_acronym: "OCO", team_name: "Alpine", team_colour: "2293D1", headshot_url: URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/E/ESTOCO01_Esteban_Ocon/estoco01.png.transform/1col/image.png")!, country_code: "FRA"), session: Session(key: 9523, name: "Race", type: "Race", date_start: "2024-05-24T13:00:00.000Z", date_end: "2024-05-24T15:00:00.000Z"))
}
