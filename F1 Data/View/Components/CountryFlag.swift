//
//  CountryFlag.swift
//  F1 Data
//
//  Created by Florian DAVID on 10/09/2024.
//

import SwiftUI

struct CountryFlag: View {
    @State private var url: URL?
    @State var width: Double
    
    init(code: String, width: Double) {
        let codeNew = code.replacingOccurrences(of: " ", with: "-").lowercased()
        self.url = URL(string: "https://cdn.countryflags.com/thumbs/\(codeNew)/flag-800.png")
        self.width = width
    }
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Rectangle()
                .fill(Color.clear)
                .frame(maxHeight: 10)
        }
        .frame(width: CGFloat(width))
        .cornerRadius(0.2 * width)
        .shadow(radius: 10)
    }
}

#Preview {
    CountryFlag(code: "France", width: 100)
}
