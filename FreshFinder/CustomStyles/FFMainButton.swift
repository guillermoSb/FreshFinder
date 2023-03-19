//
//  FilledButton.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI

struct FFMainButton: ButtonStyle {
    
    private let backgroundColor: Color
    
    init() {
        backgroundColor = .blue
    }
    
    init(backgroundColor: Color) {
        self.backgroundColor = backgroundColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .foregroundColor(configuration.isPressed ? .white.opacity(0.8) : .white)
            .background(backgroundColor)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            .opacity(configuration.isPressed ? 0.3 : 1)
            .animation(.linear(duration: 0.08), value: configuration.isPressed)

    }
}
