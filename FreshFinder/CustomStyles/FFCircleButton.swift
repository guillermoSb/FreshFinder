//
//  FFCircleButton.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/18/23.
//

import SwiftUI



struct FFCircleButton: ButtonStyle {
    
    let foregroundColor: Color
    
    
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 60, height: 60)
            .padding()
            .foregroundColor(configuration.isPressed ? foregroundColor.opacity(0.8) : foregroundColor)
            .background(
                Circle()
                    .fill(foregroundColor.opacity(0.2))
            )
            .animation(.linear(duration: 0.08), value: configuration.isPressed)

    }
    private let iconSize: CGFloat = 50

}
