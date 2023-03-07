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
    @State private var items: [GroceryListItem] = []
    @State private var selectedItem: GroceryListItem? = nil
    @EnvironmentObject var groceryListStore: GroceryListStore
    
    var budget: Double {
        items.reduce(0) { partialResult, item in
            partialResult + (item.price ?? 0) * Double(item.quantity)
        }
    }
    
    init(){}
    init(listName: String, items: [GroceryListItem]) {
       _listName = State(initialValue: listName)
       _items = State(initialValue: items)
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Nombre", text: $listName)
                        .minimumScaleFactor(0.75)
                } header: {
                    Text("Información de tu lista")
                }
                Text("\(budget.toCurrencyString())")
                    .font(.largeTitle)
                    .minimumScaleFactor(0.75)
                    .listRowInsets(.init())
                    .listRowBackground(Color.white.opacity(0))
                    .frame(maxWidth: .infinity, alignment: .center)
                Section {
                    List {
                        ForEach(items, id: \.self) { item in
                            FFItemCell(itemName: item.name, itemQuantity: item.quantity, itemPrice: item.price)
                                .onTapGesture {
                                    selectedItem = item
                                    showItemForm = true
                                }
                                
                        }
                        .onDelete { positionsRemoved in
                            items.remove(atOffsets: positionsRemoved)
                        }
                        .onMove { positionsMoved, destinationPosition in
                            items.move(fromOffsets: positionsMoved, toOffset: destinationPosition)
                        }
                        Button("Agregar") {
                            selectedItem = GroceryListItem(name: "", quantity: 1)
                        }
                        .sheet(item: $selectedItem) { item in
                            FFGroceryListItemForm(selectedItem: $selectedItem, items: $items)
                        }
                    }
                    
                    
                } header: {
                    Text("Productos")
                } footer: {
                    Text("Arrastra los elementos de la lista para modificar su orden.")
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
        let view = FFGroceryListForm(listName: "Prueba", items: [
            GroceryListItem(name: "Manzana", quantity: 1)
        ])
        return view
            .environmentObject(GroceryListStore())
    }
}
