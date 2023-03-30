//
//  GroceryListStore.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/4/23.
//

import Foundation
import Combine
import RealmSwift

class GroceryListStore: ObservableObject {

    
    func addList(_ groceryList: GroceryList) {
        try! Persistence.shared.realm.write {
            Persistence.shared.realm.add(groceryList)
        }
    }
    
    
    func editList(_ groceryList: GroceryList, name: String, items: [GroceryListItem]) {
        let groceryListFromRealm = Persistence.shared.realm.object(ofType: GroceryList.self, forPrimaryKey: groceryList._id)
        if let groceryListFromRealm {
            try! Persistence.shared.realm.write {
                groceryListFromRealm.name = name
                groceryListFromRealm.items.removeAll()
                for item in items {
                    let newItem = GroceryListItem(value: ["name": item.name, "price": item.price as Any, "quantity": item.quantity, "measureUnit": item.measureUnit, "purchased": item.purchased])
                    groceryListFromRealm.items.append(newItem)
                }
            }
        }
        
    }
    
    
    func toggleItemPurchased(_ item: GroceryListItem) {
        let groceryListItemFromRealm = Persistence.shared.realm.object(ofType: GroceryListItem.self, forPrimaryKey: item._id)
        if let groceryListItemFromRealm {
            try! Persistence.shared.realm.write {
                groceryListItemFromRealm.purchased.toggle()
            }
        }
    }
    
    
    func reset(_ groceryList: GroceryList) {
        let groceryListFromRealm = Persistence.shared.realm.object(ofType: GroceryList.self, forPrimaryKey: groceryList._id)
        if let groceryListFromRealm {
            try! Persistence.shared.realm.write {
                for item in groceryListFromRealm.items {
                    item.purchased = false
                }
            }
        }
    }
    
}
