//
//  FFProductCell.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/3/23.
//

import SwiftUI

struct FFItemCell: View {
    var itemName: String
    var itemPrice: Double?
    var itemQuantity: Int
    
    var body: some View {
        HStack {
            Text("\(itemQuantity)").fontWeight(.semibold)
            Text(itemName).fontWeight(.semibold)
            Spacer()
            Group {
                if let itemPrice {
                    Text("\(itemPrice.toCurrencyString())")
                } else {
                    Text("Precio no disponible")
                }
                
            }
            .fontWeight(.light)
           
        }
        
    }
}

struct FFProductCell_Previews: PreviewProvider {
    static var previews: some View {
        FFItemCell(itemName: "Manzanas", itemPrice: 33.333, itemQuantity: 2)
    }
}
