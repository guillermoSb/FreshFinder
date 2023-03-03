//
//  FFGroceryListItemForm.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI

struct FFGroceryListItemForm: View {
    @Binding var isPresented: Bool
    @State var itemName: String = ""
    @State var itemPrice: String = ""
    @State var itemQuantity: Int = 1
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Nombre del producto", text: $itemName)
                    TextField("Precio", text: $itemPrice)
                        .keyboardType(.decimalPad)
                    Stepper(value: $itemQuantity, in: 1...100, step: 1) {
                        Text("Cantidad: \(itemQuantity)")
                    }
                } header: {
                    Text("Información del producto")
                }
                Section {
                    Button("Agregar") {
                        isPresented = false
                    }
                    .buttonStyle(FFMainButton())
                }
                .listRowInsets(.init())
                .listRowBackground(Color.white.opacity(0))

            }
            .navigationTitle("Agregar Producto")
            .toolbar {
                Button("Cancel") {
                    isPresented = false
                }
            }
            
        }
        
    }
}

struct FFGroceryListItemForm_Previews: PreviewProvider {
    static var previews: some View {
        FFGroceryListItemForm(isPresented: .constant(true))
    }
}
