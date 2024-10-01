//
//  SubViewAlert.swift
//  F1 Data
//
//  Created by Florian DAVID on 12/09/2024.
//

import SwiftUI

struct SubViewAlert<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @State var action: () -> Void
    @State var content: () -> Content

    var body: some View {
        ZStack {
            let color = colorScheme == .dark ? Color.white : Color.black
            color.opacity(0.3)
                .edgesIgnoringSafeArea(.all)

            VStack {
                content()
                
                Button(action: action) {
                    Text("OK")
                        .F1Bold(size: 20)
                        .underline()
                }
            }
            .padding(20)
            .background(colorScheme == .dark ? .black : .white)
            .cornerRadius(15)
            .shadow(radius: 5)
        }
    }
}

#Preview {
    ZStack {
        SubViewAlert(action: {print("ok")}) {
            StintsDriverRaceView(driver_number: 31, session_key: 9094)
        }
    }
}
