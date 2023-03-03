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
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            
            
            
        
            
        
    }
}
