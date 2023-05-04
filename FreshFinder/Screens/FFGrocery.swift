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
    
    @State private var currentItemEdited: GroceryListItem? = nil
    @State private var buttonColorChange: Bool = false
    @State private var showEditItemSheed = false
    
    var body: some View {
        VStack(spacing: 24) {
            Text(groceryViewModel.currentItem.wrappedName)
                .font(.system(size: itemFontSize))
            VStack(alignment: .center, spacing: 12) {
                Text("Cantidad: \(groceryViewModel.currentItem.quantity)")
                Text(groceryViewModel.currentItem.measureUnit.rawValue)
                if let price = groceryViewModel.currentItem.price {
                    Text("Precio Unitario: \(price.toCurrencyString(groceryViewModel.grocery.list.currency))")
                    Text("Total: \((Double(groceryViewModel.currentItem.quantity) * price).toCurrencyString(groceryViewModel.grocery.list.currency))")
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
                withAnimation(.easeIn(duration: 0.20)) {
                    buttonColorChange.toggle()
                }
                
            } label: {
                Image(systemName: groceryViewModel.currentItemPurchased ? "xmark" : "cart.fill")
                    .font(.system(size: iconSize))
                    .foregroundColor(buttonColorChange ? .red : .green)
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
                          !groceryViewModel.grocery.list.wrappedItems.hasPrevIndex(for: groceryViewModel.currentItemIndex!)
                          : true)
                Button {
                    presentation.wrappedValue.dismiss()
                } label: {
                    Text("Listo")
                }
                .buttonStyle(FFMainButton(backgroundColor: .blue))
                
                Button {
                    groceryViewModel.nextItem()
                    buttonColorChange = groceryViewModel.currentItemPurchased
                } label: {
                    Text("Siguiente")
                }
                .disabled(groceryViewModel.currentItemIndex != nil ?
                          !groceryViewModel.grocery.list.wrappedItems.hasNextItem(for: groceryViewModel.currentItemIndex!)
                          : true)
            }
            
            
        }
        .onAppear {
            buttonColorChange = groceryViewModel.currentItemPurchased
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Editar") {
                    self.currentItemEdited = groceryViewModel.currentItem
                    self.showEditItemSheed = true
                }
            }
        }
        .sheet(item: $currentItemEdited) { item in
            FFGroceryListItemForm(isQuickEdit: true, selectedItem: $currentItemEdited, items: .constant([]))
                .environmentObject(groceryViewModel)
        }
        
    }
        
    private let itemFontSize: CGFloat = 52
    private let iconSize: CGFloat = 40
}

struct FFGrocery_Previews: PreviewProvider {
    static var previews: some View {
        FFGrocery(groceryViewModel: GroceryViewModel(with: GroceryList(name: "My List", currency: .quetzal, items: [GroceryListItem(name: "Manzana", quantity: 12, price: 0.12)])))
            
    }
}
