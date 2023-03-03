//
//  FFGroceryListForm.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI

struct FFGroceryListForm: View {
    @Environment(\.presentationMode) var presentation
    @State private var listName: String = ""
    @State private var showItemForm: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Nombre", text: $listName)
                        .minimumScaleFactor(0.75)
                } header: {
                    Text("Información de tu lista")
                }
                Section {
                    List {
                        Text("1")
                        Text("2")
                        Button("Agregar") {
                            showItemForm = true
                        }
                        .sheet(isPresented: $showItemForm) {
                            FFGroceryListItemForm(isPresented: $showItemForm)
                        }
                    }
                } header: {
                    Text("Productos")
                }
                
                Section {
                    Button("Guardar") {
                        presentation.wrappedValue.dismiss()
                    }
                    .buttonStyle(FFMainButton())
                }
                .listRowInsets(.init())
                .listRowBackground(Color.white.opacity(0))
                                
                                
                                
                
            }
            
            .navigationTitle("Nueva Lista")
        }
    }
}

struct FFGroceryListForm_Previews: PreviewProvider {
    
    static var previews: some View {
        FFGroceryListForm()
    }
}
