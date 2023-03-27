//
//  GroceryList.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/4/23.
//

import Foundation
import RealmSwift


class GroceryList: Object, Identifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var createdAt = Date()
    
    // Items for this GroceryList
    @Persisted var items: List<GroceryListItem>
    
    convenience init(name: String, items: [GroceryListItem]) {
        self.init()
        self.name = name
        self.items.append(objectsIn: items)
    }
}

class GroceryListItem: Object, Identifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var quantity = 0
    @Persisted var measureUnit: MeasureUnit = .unit
    @Persisted var price: Double?
}


enum MeasureUnit: String, PersistableEnum {
    case unit = "Unidad"
    case pound = "Libra"
    case liter = "Litro"
    case dozen = "Docena"
}


