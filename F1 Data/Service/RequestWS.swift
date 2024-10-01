//
//  RequestWS.swift
//  F1 Data
//
//  Created by Florian DAVID on 07/09/2024.
//

import Foundation

enum WSError: Error {
    case invalidURL
    case invalidStatusCode(code: Int)
}

class RequestWS {
    /**
     * Retourne l'URL principal du web service (stockée dans une variable d'environnement nommée URL_WS)
     */
    private static func getWebServiceURL() -> String {
        guard let url = ProcessInfo.processInfo.environment["URL_WS"] else {
            return ""
        }
        return url
    }
    
    /**
     * Récupère les informations par rapport à une URL (utilisé seulement pour des requêtes avec paramètres ou des queries)
     * @route email : la route de l'API Node.js correspondante
     * @queryItems: les queries à passer à la route
     * @to: le type de l'objet à récupérer
     * @return: l'objet décodé
     */
    static func decodeAPIInfo<T: Decodable>(route: String, queryItems: [URLQueryItem], to: T.Type) async throws -> T {
        let urlString = "\(RequestWS.getWebServiceURL())/\(route)"
        
        if var urlComponents = URLComponents(string: urlString) {
            urlComponents.queryItems = queryItems
            //urlComponents.queryItems?.append(URLQueryItem(name: "lang", value: String(Locale.preferredLanguages.first?.prefix(2) ?? "en")))

            if let url = urlComponents.url {
                let request = URLRequest(url: url)
                let (data, resp) = try await URLSession.shared.data(for: request)
                
                let response = (resp as? HTTPURLResponse)!
                if response.statusCode != 200 {
                    print("Erreur \(route) : ")
                    throw WSError.invalidStatusCode(code: response.statusCode)
                }
                
                let decodingData = try JSONDecoder().decode(T.self, from: data)
                return decodingData
            }
        }
        
        throw WSError.invalidURL
    }
}
