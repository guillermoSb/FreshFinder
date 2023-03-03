//
//  FFGroceryListForm.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI

struct FFGroceryListForm: View {
    @Binding var presentGroceryListForm: Bool
    @State var listName: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Nombre", text: $listName)
                } header: {
                    Text("Información de tu lista")
                }
                
                Section {
                    List {
                        Text("1")
                        Text("2")
                        Button("Agregar") {}
                    }
                } header: {
                    Text("Productos")
                }

            }
            .navigationTitle("Nueva Lista")
            .toolbar {
                Button("Cancelar") {
                    presentGroceryListForm = false
                }
            }
        }
    }
}

struct FFGroceryListForm_Previews: PreviewProvider {
    
    static var previews: some View {
        FFGroceryListForm(presentGroceryListForm: Binding.constant(true))
    }
}
