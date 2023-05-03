//
//  FFProductCell.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/3/23.
//

import SwiftUI

struct FFItemCell: View {
    let currency: Currency
    var purchased = true
    var itemName: String
    var itemQuantity: Int
    var itemPrice: Double?
    
    var body: some View {
        ZStack {
            HStack {
                Text("\(itemQuantity)").fontWeight(.semibold)
                Text(itemName).fontWeight(.semibold)
                Spacer()
                Group {
                    if let itemPrice {
                        Text("\(itemPrice.toCurrencyString(currency))")
                    } else {
                        Text("Precio no disponible")
                    }
                    
                }
                .fontWeight(.light)
               
            }
            if purchased {
               RoundedRectangle(cornerRadius: 10)
                    .fill(.green.opacity(0.5))
                    .frame(height:1)
                    
                    
            }
        }
        
        
    }
}

struct FFProductCell_Previews: PreviewProvider {
    static var previews: some View {
        FFItemCell(currency: .quetzal,itemName: "Manzanas", itemQuantity: 2, itemPrice: 33.333)
    }
}
