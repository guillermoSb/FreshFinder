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
        VStack(spacing: 24) {
            Text(currentItem.name)
                .font(.system(size: itemFontSize))
            VStack(alignment: .leading, spacing: 12) {
                Text("Cantidad: \(currentItem.quantity)")
                if let price = currentItem.price {
                    Text("Precio Unitario: \(price.toCurrencyString())")
                    Text("Total: \((Double(currentItem.quantity) * price).toCurrencyString())")
                }
            }
            .font(.title3)
            
            Spacer()
            HStack {
                Button {
                    // Start Shopping session
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: iconSize))
                        .tint(.red)
                }
                .buttonStyle(FFCircleButton(foregroundColor: .red))
                Spacer()
                Button {
                    // Start Shopping session
                } label: {
                    Image(systemName: "cart.fill")
                        .font(.system(size: iconSize))
                        .tint(.green)
                       
                }
                .buttonStyle(FFCircleButton(foregroundColor: .green))
            }
            .padding(.horizontal, 52)
            .padding(.bottom, 20)
        }
        
    }
    
    private let itemFontSize: CGFloat = 52
    private let iconSize: CGFloat = 40
}

struct FFGrocery_Previews: PreviewProvider {
    static var previews: some View {
        FFGrocery(currentItem: GroceryListItem(name: "Manzana", quantity: 12, price: 1.50))
    }
}
