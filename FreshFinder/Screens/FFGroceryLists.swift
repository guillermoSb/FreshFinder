//
//  FFGroceryLists.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI

struct FFGroceryLists: View {
    
    @ObservedObject var groceryListStore: GroceryListStore

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: FFGroceryListForm()) {
                    Text("Nueva Lista")
                }
                .buttonStyle(FFMainButton())
                Spacer()
            }
            .padding(.top, 24)
            .navigationTitle("Tus Listas")
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
    }
}

struct FFGroceryLists_Previews: PreviewProvider {
    static var previews: some View {
        FFGroceryLists(groceryListStore: GroceryListStore())
    }
}
