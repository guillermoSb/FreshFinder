//
//  GroceryList.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/4/23.
//

import Foundation
import RealmSwift

//struct GroceryList: Hashable, Identifiable {
//    var id: String {
//        return UUID().uuidString
//    }
//    var name: String
//    var items: [GroceryListItem]
//}
//
//struct GroceryListItem: Hashable, Identifiable {
//    var id: String {
//        return UUID().uuidString
//    }
//    var name: String
//    var quantity: Int
//    var price: Double?
//}

class GroceryList: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var createdAt = Date()
    
    // Items for this GroceryList
    @Persisted var items: List<GroceryListItem>
}

class GroceryListItem: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var quantity = 0
    @Persisted var price: Double?
}


