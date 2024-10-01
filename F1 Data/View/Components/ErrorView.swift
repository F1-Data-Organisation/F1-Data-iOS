//
//  ErrorView.swift
//  F1 Data
//
//  Created by Florian DAVID on 19/09/2024.
//

import SwiftUI

struct ErrorView: View {
    @State var error: Error
    @State private var color: Color
    @State private var status: Int?
    
    init(error: Error) {
        self.error = error
        
        if let wsError = error as? WSError {
            switch wsError {
                case .invalidStatusCode(let code):
                    self.status = code
                    self.color = code > 404 ? .red : .yellow
                case .invalidURL:
                    self.color = .blueFlag
            }
        } else {
            self.color = .primary
        }
    }
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            
            if let code = status {
                Text("Error \(code) - \(error.localizedDescription)")
            } else {
                Text(error.localizedDescription)
            }
        }
        .F1Bold(size: 16)
        .foregroundColor(color.constrasting())
        .padding()
        .background(color)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    ErrorView(error: WSError.invalidStatusCode(code: 404))
}
