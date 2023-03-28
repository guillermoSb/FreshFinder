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
            // Get the removed items
            
            try! Persistence.shared.realm.write {
                groceryListFromRealm.name = name
                groceryListFromRealm.items.removeAll()
                for item in items {
                    let newItem = GroceryListItem(value: ["name": item.name, "price": item.price as Any, "quantity": item.quantity, "measureUnit": item.measureUnit])
                    groceryListFromRealm.items.append(newItem)
                }
            }
        }
        
    }
    
}
