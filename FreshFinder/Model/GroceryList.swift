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
    @Persisted var currency: Currency = .quetzal
    
    // Items for this GroceryList
    @Persisted var items: List<GroceryListItem>
    
    convenience init(name: String, currency: Currency = .quetzal, items: [GroceryListItem]) {
        self.init()
        self.name = name
        self.currency = currency
        self.items.append(objectsIn: items)
    }
}

class GroceryListItem: Object, Identifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var quantity = 0
    @Persisted var measureUnit: MeasureUnit = .unit
    @Persisted var price: Double?
    @Persisted var purchased: Bool = false
    
    convenience init(name: String, quantity: Int, measureUnit: MeasureUnit = .unit, price: Double?) {
        self.init()
        self.name = name
        self.quantity = quantity
        self.measureUnit = measureUnit
        self.price = price
    }
}


enum MeasureUnit: String, PersistableEnum {
    case unit = "Unidad"
    case pound = "Libra"
    case liter = "Litro"
    case dozen = "Docena"
}

enum Currency: String, PersistableEnum {
    case quetzal = "GTQ"
    case dollar = "USD"
    case euro = "EUR"
    case mexicanPeso = "MXN"
}


