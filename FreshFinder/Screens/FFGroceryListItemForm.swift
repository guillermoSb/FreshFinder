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
    @State var itemUnit: MeasureUnit = .unit
  
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
                    Picker("Unidad de medida", selection: $itemUnit) {
                        ForEach(MeasureUnit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    Stepper(value: $itemQuantity, in: 1...100, step: 1) {
                        Text("Cantidad: \(itemQuantity)")
                    }
                } header: {
                    Text("Información del producto")
                }
                Section {
                    Button("\(editMode ? "Editar" : "Guardar")") {
                        let newItem = GroceryListItem(value: ["name": itemName, "quantity": itemQuantity, "measureUnit": itemUnit ])
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
                    selectedItem = nil  // Remove the binding so the view can be dismissed
                }
            }
            
        }
        .onAppear {
            focusedField = .itemName    // Set the focus on the item name
            if let selectedItem {
                // Add to the state fields the item fields
                itemName = selectedItem.name
                itemQuantity = selectedItem.quantity
                itemPrice = selectedItem.price != nil ? String(format: "%.2f", selectedItem.price!) : ""
                itemUnit = selectedItem.measureUnit
            }
        }
        
    }
}

struct FFGroceryListItemForm_Previews: PreviewProvider {
    static var previews: some View {
        FFGroceryListItemForm(selectedItem: .constant(GroceryListItem(value: ["name": "Manzana", "quantity": 2])), items: .constant([
            GroceryListItem(value: ["name": "Manzana", "quantity": 2])
        ]))
    }
}
