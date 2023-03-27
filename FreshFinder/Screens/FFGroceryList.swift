//
//  FFGroceryList.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/9/23.
//

import SwiftUI

struct FFGroceryList: View {
    let groceryList: GroceryList
    var body: some View {
        VStack(spacing: 24) {
            Text(groceryList.name).font(.largeTitle)
            Text(groceryList.items.budget().toCurrencyString()).font(.title2)
            HStack(spacing: 24) {
                NavigationLink {
                    FFGrocery(groceryViewModel: GroceryViewModel(with: self.groceryList))
                } label: {
                    Image(systemName: "play.fill")
                        .font(.system(size: iconSize))
                        .tint(.green)
                    
                }
                .buttonStyle(FFCircleButton(foregroundColor: .green))

                Button {
                    // Restart
                } label: {
                    Text("Reiniciar")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.blue)
                }
                .buttonStyle(FFMainButton(backgroundColor: .blue.opacity(0.2)))
            }
            
            VStack(alignment: .leading, spacing: 24) {
                Text("Productos en esta lista")
                    .padding(.leading, 20)
                List {
                    ForEach(groceryList.items, id: \._id) { item in
                        FFItemCell(itemName: item.name, itemQuantity: item.quantity, itemPrice: item.price)
                    }
                }
                .listStyle(.plain)
            }
            
        }
        
        
    }
    
    private let iconSize: CGFloat = 50
}

struct FFGroceryList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FFGroceryList(groceryList: GroceryList(value: ["name": "My Test List"]))
        }
    }
}
