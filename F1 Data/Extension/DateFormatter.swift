//
//  DateFormatter.swift
//  F1 Data
//
//  Created by Florian DAVID on 08/09/2024.
//

import Foundation

extension String {
    func toDate(withHours: Bool) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let lang = Locale.preferredLanguages.first?.prefix(2)

        // Convertir la chaîne en Date
        if let date = dateFormatter.date(from: self) {
            
            // Créer un DateFormatter pour afficher l'heure dans le fuseau horaire de l'utilisateur
            let userTimeZoneFormatter = DateFormatter()
            userTimeZoneFormatter.timeZone = TimeZone.current // Le fuseau horaire de l'utilisateur actuel

            if withHours {
                userTimeZoneFormatter.dateFormat = lang == "fr" ? "dd/MM/yyyy HH:mm" : "yyyy/MM/dd HH:mm"
            } else {
                userTimeZoneFormatter.dateFormat = lang == "fr" ? "dd/MM/yyyy" : "yyyy/MM/dd"
            }
            
            // Convertir la date en fonction du fuseau horaire de l'utilisateur
            let localTimeString = userTimeZoneFormatter.string(from: date)
            return localTimeString
        } else {
            print("Impossible de convertir la date")
            return self
        }
    }
}
