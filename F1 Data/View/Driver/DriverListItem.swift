//
//  DriverListItem.swift
//  F1 Data
//
//  Created by Florian DAVID on 20/09/2024.
//

import SwiftUI

struct DriverListItem: View {
    @State var driver: Driver
    
    var body: some View {
        HStack {
            AsyncImage(url: driver.headshot_url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .background(Color(hex: driver.team_colour))
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(driver.full_name)
                    .F1Bold(size: 20)
                
                if let team = driver.team_name {
                    Text(team)
                        .F1Regular(size: 14)
                }
            }
        }
    }
}

#Preview {
    DriverListItem(driver: Driver(driver_number: 31, full_name: "Esteban OCON", name_acronym: "OCO", team_name: "Alpine", team_colour: "2293D1", headshot_url: URL(string: "https://www.formula1.com/content/dam/fom-website/drivers/E/ESTOCO01_Esteban_Ocon/estoco01.png.transform/1col/image.png")!, country_code: "FRA"))
}
