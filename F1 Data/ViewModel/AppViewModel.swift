//
//  AppViewModel.swift
//  F1 Data
//
//  Created by Florian DAVID on 01/10/2024.
//

import Foundation
import SwiftUI

@MainActor
class AppViewModel: ObservableObject {
    @Published var subAlertPresent: Bool = false
    @Published var subAlertView: AnyView = AnyView(EmptyView())
    
    func setViewAlert(view: some View) {
        self.subAlertPresent = true
        self.subAlertView = AnyView(view)
    }
}
