//
//  GroceryList.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/4/23.
//

import Foundation


struct GroceryList: Hashable, Identifiable {
    var id: String {
        return UUID().uuidString
    }
    var name: String
    var items: [GroceryListItem]
}

struct GroceryListItem: Hashable, Identifiable {
    var id: String {
        return UUID().uuidString
    }
    var name: String
    var quantity: Int
    var price: Double?
}
