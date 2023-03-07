//
//  FFGroceryListItemForm.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI

struct FFGroceryListItemForm: View {
    @Binding var selectedItem: GroceryListItem?
    @Binding var items: [GroceryListItem]
    
    @State var itemName: String = ""
    @State var itemPrice: String = ""
    @State var itemQuantity: Int = 1
    
    var editMode: Bool {
        guard let selectedItem else {return false}
        let idx = items.firstIndex(of: selectedItem)
        guard idx != nil else { return false }
        return true
    }
    
    
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
                    Button("\(editMode ? "Editar" : "Guardar")") {
                        var newItem = GroceryListItem(name: itemName, quantity: itemQuantity)
                        if let price = Double(itemPrice) {
                            newItem.price = price
                        }
                        
                        if let selectedItem, let idx = items.firstIndex(of: selectedItem) {
                            if editMode {
                                items[idx] = newItem
                            }
                        } else {
                            items.append(newItem)
                        }
                        selectedItem = nil
                    }
                    .buttonStyle(FFMainButton())
                }
                .listRowInsets(.init())
                .listRowBackground(Color.white.opacity(0))
                
            }
            .navigationTitle("\(editMode ? "Editar" : "Crear") Producto")
            .toolbar {
                Button("Cancelar") {
                    selectedItem = nil
                }
            }
            
        }
        .onAppear {
            if let selectedItem {
                itemName = selectedItem.name
                itemQuantity = selectedItem.quantity
                itemPrice = selectedItem.price != nil ? String(format: "%.2f", selectedItem.price!) : ""
            }
        }
        
    }
}

struct FFGroceryListItemForm_Previews: PreviewProvider {
    static var previews: some View {
        FFGroceryListItemForm(selectedItem: .constant(GroceryListItem(name: "Manzana", quantity: 2)), items: .constant([
            GroceryListItem(name: "Manzana", quantity: 2)
            ]))
    }
}
