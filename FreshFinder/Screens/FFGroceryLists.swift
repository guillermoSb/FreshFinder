//
//  FFGroceryLists.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI

struct FFGroceryLists: View {
    @State private var presentGroceryListForm = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Button("Nueva Lista") {
                    presentGroceryListForm = true
                }
                .buttonStyle(FFMainButton())
                Spacer()
            }
            .padding(.top, 24)
            .sheet(isPresented: $presentGroceryListForm) {
                FFGroceryListForm(presentGroceryListForm: $presentGroceryListForm)
            }
            .navigationTitle("Tus Listas")
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
    }
}

struct FFGroceryLists_Previews: PreviewProvider {
    static var previews: some View {
        FFGroceryLists()
    }
}
