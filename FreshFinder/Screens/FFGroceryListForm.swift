//
//  FFGroceryListForm.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI

struct FFGroceryListForm: View {
    @Binding var presentGroceryListForm: Bool
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button("Cancelar") {
                    presentGroceryListForm = false
                }
            }
            .padding(.top, 24)
            
            Text("Nueva Lista")
                .font(.largeTitle).bold()
            Spacer()
        }
        .padding(.horizontal, 24)
        
        
    }
}

struct FFGroceryListForm_Previews: PreviewProvider {
    
    static var previews: some View {
        FFGroceryListForm(presentGroceryListForm: Binding.constant(true))
    }
}
