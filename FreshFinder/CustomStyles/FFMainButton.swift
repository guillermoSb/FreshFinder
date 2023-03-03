//
//  FilledButton.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI

struct FFMainButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .foregroundColor(configuration.isPressed ? .white.opacity(0.8) : .white)
            .background(.blue)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
            
            
            
        
            
        
    }
}
