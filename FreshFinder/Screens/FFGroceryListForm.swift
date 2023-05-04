//
//  FFGroceryListForm.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI

struct FFGroceryListForm: View {
    @Environment(\.presentationMode) var presentation
    
    private var groceryList: GroceryList?
    let currencyOptions = Currency.allCases

    @State private var listName: String = ""
    @State private var currency: Currency = .quetzal
    @State private var items: [GroceryListItem] = []
    @State private var selectedItem: GroceryListItem? = nil
    @EnvironmentObject var groceryListStore: GroceryListStore
    
    init(){}
    
    init(listName: String, items: [GroceryListItem]) {
        _listName = State(initialValue: listName)
        _items = State(initialValue: items)
    }
    
    init(from groceryList: GroceryList) {
        self.groceryList = groceryList
        _currency = State(initialValue: groceryList.currency)
        _listName = State(initialValue: groceryList.name)
        _items = State(initialValue: groceryList.items.map({$0}))

    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Nombre", text: $listName)
                        .minimumScaleFactor(0.75)
                    Picker("Selecciona una moneda", selection: $currency) {
                        ForEach(currencyOptions, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                } header: {
                    Text("Información de tu lista")
                }
                Text("\(items.budget().toCurrencyString(currency))")
                    .font(.largeTitle)
                    .minimumScaleFactor(0.75)
                    .listRowInsets(.init())
                    .listRowBackground(Color.white.opacity(0))
                    .frame(maxWidth: .infinity, alignment: .center)
                Section {
                    List {
                        ForEach(items, id: \._id) { item in
                            FFItemCell(currency: currency, purchased: false,itemName: item.name, itemQuantity: item.quantity, itemPrice: item.price)
                                .onTapGesture {
                                    selectedItem = item
                                }

                        }
                        .onDelete { positionsRemoved in
                            items.remove(atOffsets: positionsRemoved)
                        }
                        .onMove { positionsMoved, destinationPosition in
                            items.move(fromOffsets: positionsMoved, toOffset: destinationPosition)
                        }
                        
                        Button("Agregar") {
                            selectedItem = GroceryListItem(value: ["name": "", "quantity": 1])
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
                        if let groceryList {
                            groceryListStore.editList(groceryList, name: listName, currency: currency ,items: items)
                            
                        } else {
                            groceryListStore.addList(GroceryList(name: listName, currency: currency, items: items))
                        }
                        presentation.wrappedValue.dismiss()
                    }
                    .buttonStyle(FFMainButton())
                    .disabled(items.isEmpty)
                }
                .listRowInsets(.init())
                .listRowBackground(Color.white.opacity(0))
            }
            .navigationTitle(groceryList != nil ? "Editar Lista" : "Nueva Lista")
        }
        
    }
}

struct FFGroceryListForm_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = FFGroceryListForm(listName: "Prueba", items: [
            
        ])
        return view
            .environmentObject(GroceryListStore())
    }
}



//Form {
//    Section {
//        TextField("Nombre", text: $listName)
//            .minimumScaleFactor(0.75)
//    } header: {
//        Text("Información de tu lista")
//    }
//    Text("\(items.budget().toCurrencyString())")
//        .font(.largeTitle)
//        .minimumScaleFactor(0.75)
//        .listRowInsets(.init())
//        .listRowBackground(Color.white.opacity(0))
//        .frame(maxWidth: .infinity, alignment: .center)
//    Section {
//        List {
//            ForEach(items, id: \.self) { item in
//                FFItemCell(itemName: item.name, itemQuantity: item.quantity, itemPrice: item.price)
//                    .onTapGesture {
//                        selectedItem = item
//                    }
//
//            }
//            .onDelete { positionsRemoved in
//                items.remove(atOffsets: positionsRemoved)
//            }
//            .onMove { positionsMoved, destinationPosition in
//                items.move(fromOffsets: positionsMoved, toOffset: destinationPosition)
//            }
//            Button("Agregar") {
//                selectedItem = GroceryListItem(name: "", quantity: 1)
//            }
//            .sheet(item: $selectedItem) { item in
//                FFGroceryListItemForm(selectedItem: $selectedItem, items: $items)
//            }
//        }
//
//
//    } header: {
//        Text("Productos")
//    } footer: {
//        Text("Arrastra los elementos de la lista para modificar su orden.")
//    }
//

//}
//.navigationTitle("Nueva Lista")
