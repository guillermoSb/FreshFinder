//
//  FFGroceryListItemCell.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/9/23.
//

import SwiftUI

@ViewBuilder
func groceryListCell(groceryList: GroceryList) -> some View {
    HStack {
        VStack(alignment: .leading, spacing: 12) {
            Text(groceryList.wrappedName)
                .font(.title2)
            Text("\(groceryList.wrappedItems.count) productos")
        }
        Spacer()
        Text(groceryList.wrappedItems.budget().toCurrencyString())
            .font(.title)
    }
    .padding(24)
    .background(
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .strokeBorder(Color.black, lineWidth: 2)
            .background(RoundedRectangle(cornerRadius: 20).fill(.thinMaterial))
    )
    
}
