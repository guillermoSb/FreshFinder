//
//  FFGrocery.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/18/23.
//

import SwiftUI

struct FFGrocery: View {
    @State var currentItem: GroceryListItem
    var body: some View {
        VStack {
            Text(currentItem.name)
                .font(.system(size: itemFontSize))
            Text("Cantidad: \(currentItem.quantity)")
            if let price = currentItem.price {
                Text("Precio Unitario: \(price.toCurrencyString())")
            }
            
            
            Spacer()
            HStack {
                
            }
        }
    }
    
    private let itemFontSize: CGFloat = 50.0
}

struct FFGrocery_Previews: PreviewProvider {
    static var previews: some View {
        FFGrocery(currentItem: GroceryListItem(name: "Manzana", quantity: 12, price: 1.50))
    }
}
