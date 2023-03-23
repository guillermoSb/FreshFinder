//
//  FFGrocery.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/18/23.
//

import SwiftUI

struct FFGrocery: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var groceryViewModel: GroceryViewModel
    
    
    var body: some View {
        VStack(spacing: 24) {
            Text(groceryViewModel.currentItem.name)
                .font(.system(size: itemFontSize))
            VStack(alignment: .leading, spacing: 12) {
                Text("Cantidad: \(groceryViewModel.currentItem.quantity)")
                if let price = groceryViewModel.currentItem.price {
                    Text("Precio Unitario: \(price.toCurrencyString())")
                    Text("Total: \((Double(groceryViewModel.currentItem.quantity) * price).toCurrencyString())")
                }
            }
            .font(.title3)
            
            Spacer()
            if groceryViewModel.currentItemPurchased {
                Button {
                    groceryViewModel.discard()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: iconSize))
                        .tint(.red)
                }
                .buttonStyle(FFCircleButton(foregroundColor: .red))
            } else {
                Button {
                    groceryViewModel.buy()
                } label: {
                    Image(systemName: "cart.fill")
                        .font(.system(size: iconSize))
                        .tint(.green)
                       
                }
                .buttonStyle(FFCircleButton(foregroundColor: .green))
            }
     
            HStack(spacing: 20) {
                Button {
                    groceryViewModel.prevItem()
                } label: {
                    Text("Anterior")
                }
                .disabled(groceryViewModel.currentItemIndex != nil ?
                          !groceryViewModel.grocery.list.items.hasPrevIndex(for: groceryViewModel.currentItemIndex!)
                          : true)
                Button {
                    groceryViewModel.finish()
                    presentation.wrappedValue.dismiss()
                } label: {
                    Text("Terminar")
                }
                .buttonStyle(FFMainButton(backgroundColor: .blue))
                
                Button {
                    groceryViewModel.nextItem()
                } label: {
                    Text("Siguiente")
                }
                .disabled(groceryViewModel.currentItemIndex != nil ?
                          !groceryViewModel.grocery.list.items.hasNextItem(for: groceryViewModel.currentItemIndex!)
                          : true)
            }
           

        }
        
    }
    

    private let itemFontSize: CGFloat = 52
    private let iconSize: CGFloat = 40
}

struct FFGrocery_Previews: PreviewProvider {
    static var previews: some View {
        FFGrocery(groceryViewModel: GroceryViewModel(with: GroceryList(name: "Super Semanal", items: [
            GroceryListItem(name: "Manzana", quantity: 1, price: 1.50),
            GroceryListItem(name: "Peras", quantity: 2, price: 2.50)
        ])))
    }
}
