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
                Text("Hi")
            }
            .sheet(isPresented: $presentGroceryListForm) {
                FFGroceryListForm(presentGroceryListForm: $presentGroceryListForm)
            }
            .navigationTitle("Tus Listas")
            .toolbar {
                Button {
                    presentGroceryListForm = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct FFGroceryLists_Previews: PreviewProvider {
    static var previews: some View {
        FFGroceryLists()
    }
}
