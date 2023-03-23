//
//  FFGroceryListItemForm.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI

struct FFGroceryListItemForm: View {
    
    // Form fields that can be focused by code
    enum FocusedField {
        case itemName
    }
    
    @Binding var selectedItem: GroceryListItem?
    @Binding var items: [GroceryListItem]
    @FocusState private var focusedField: FocusedField?
    
    @State var itemName: String = ""
    @State var itemPrice: String = ""
    @State var itemQuantity: Int = 1
  
    // Wether the view is editing an item or adding
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
                        .focused($focusedField, equals: .itemName)
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
//                        var newItem = GroceryListItem(name: itemName, quantity: itemQuantity)
//                        if let price = Double(itemPrice) {
//                            newItem.price = price
//                        }
//                        if let selectedItem, let idx = items.firstIndex(of: selectedItem) {
//                            if editMode {
//                                items[idx] = newItem
//                            }
//                        } else {
//                            items.append(newItem)
//                        }
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
                    selectedItem = nil  // Remove the binding so the view can be dismissed
                }
            }
            
        }
        .onAppear {
            focusedField = .itemName    // Set the focus on the item name
            if let selectedItem {
                // Add to the state fields the item fields
                itemName = selectedItem.wrappedName
                itemQuantity = selectedItem.wrappedQuantity
                itemPrice = String(format: "%.2f", selectedItem.wrappedPrice)
            }
        }
        
    }
}

struct FFGroceryListItemForm_Previews: PreviewProvider {
    static var previews: some View {
        FFGroceryListItemForm(selectedItem: .constant(GroceryList.example.wrappedItems.first), items: .constant(GroceryList.example.wrappedItems))
    }
}
