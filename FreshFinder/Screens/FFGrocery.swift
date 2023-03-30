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
    @State private var buttonColorChange: Bool = false
    
    var body: some View {
        VStack(spacing: 24) {
            Text(groceryViewModel.currentItem.name)
                .font(.system(size: itemFontSize))
            VStack(alignment: .center, spacing: 12) {
                Text("Cantidad: \(groceryViewModel.currentItem.quantity)")
                Text(groceryViewModel.currentItem.measureUnit.rawValue)
                if let price = groceryViewModel.currentItem.price {
                    Text("Precio Unitario: \(price.toCurrencyString())")
                    Text("Total: \((Double(groceryViewModel.currentItem.quantity) * price).toCurrencyString())")
                }
            }
            .font(.title3)
            
            Spacer()
            
            Button {
                if groceryViewModel.currentItemPurchased {
                    groceryViewModel.discard()
                } else {
                    groceryViewModel.buy()
                }
                withAnimation(.easeIn(duration: 0.15)) {
                    buttonColorChange.toggle()
                }
                
            } label: {
                Image(systemName: groceryViewModel.currentItemPurchased ? "xmark" : "cart.fill")
                    .font(.system(size: iconSize))
                    .tint(buttonColorChange ? .red : .green)
            }
            .buttonStyle(FFCircleButton(foregroundColor: buttonColorChange ? .red : .green))
            
            HStack(spacing: 20) {
                Button {
                    groceryViewModel.prevItem()
                    buttonColorChange = groceryViewModel.currentItemPurchased
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
                    buttonColorChange = groceryViewModel.currentItemPurchased
                } label: {
                    Text("Siguiente")
                }
                .disabled(groceryViewModel.currentItemIndex != nil ?
                          !groceryViewModel.grocery.list.items.hasNextItem(for: groceryViewModel.currentItemIndex!)
                          : true)
            }
            
            
        }
        .onAppear {
            buttonColorChange = groceryViewModel.currentItemPurchased
        }
        
    }
    
    
    private let itemFontSize: CGFloat = 52
    private let iconSize: CGFloat = 40
}

struct FFGrocery_Previews: PreviewProvider {
    static var previews: some View {
        FFGrocery(groceryViewModel: GroceryViewModel(with: GroceryList(value: ["name": "My Test List"])))
    }
}
