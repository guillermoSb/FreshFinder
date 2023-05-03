//
//  FFGroceryList.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/9/23.
//

import SwiftUI
import RealmSwift
struct FFGroceryList: View {
    @EnvironmentObject var groceryListStore: GroceryListStore
    @ObservedRealmObject var groceryList: GroceryList
    var body: some View {
        VStack(spacing: 24) {
            Text(groceryList.name).font(.largeTitle)
            Text(groceryList.items.budget().toCurrencyString(groceryList.currency)).font(.title2)
            HStack(spacing: 24) {
                NavigationLink {
                    FFGrocery(groceryViewModel: GroceryViewModel(with: self.groceryList.freeze()))
                } label: {
                    Image(systemName: "play.fill")
                        .font(.system(size: iconSize))
                        .tint(.green)
                    
                }
                .buttonStyle(FFCircleButton(foregroundColor: .green))

                Button {
                    groceryListStore.reset(groceryList)
                } label: {
                    Text("Reiniciar")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.blue)
                }
                .disabled(groceryList.items.filter {$0.purchased}.count <= 0)
                .buttonStyle(FFMainButton(backgroundColor: .blue.opacity(0.2)))
                
            }
            
            VStack(alignment: .leading, spacing: 24) {
                Text("Productos en esta lista")
                    .padding(.leading, 20)
                List {
                    ForEach(groceryList.items, id: \._id) { item in
                        FFItemCell(currency: groceryList.currency, purchased: item.purchased, itemName: item.name, itemQuantity: item.quantity, itemPrice: item.price)
                            .onTapGesture {
                                groceryListStore.toggleItemPurchased(item)
                            }
                    }
                }
                .listStyle(.plain)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    FFGroceryListForm(from: groceryList)
                        .environmentObject(groceryListStore)
                } label: {
                    Text("Editar")
                }

            }
        }

        
        
    }
    
    private let iconSize: CGFloat = 50
}

struct FFGroceryList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FFGroceryList(groceryList: GroceryList(name: "My List", items: [GroceryListItem(name: "Manzana", quantity: 12, price: 0.12)]))
        }
    }
}
