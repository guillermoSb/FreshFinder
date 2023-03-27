//
//  GroceryListStore.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/4/23.
//

import Foundation
import Combine

class GroceryListStore: ObservableObject {

    func addList(_ groceryList: GroceryList) {
        try! Persistence.shared.realm.write {
            Persistence.shared.realm.add(groceryList)
        }
    }
    
    func deleteLists(at indexSet: IndexSet) {
//        groceryLists.remove(atOffsets: indexSet)
    }
    
}
