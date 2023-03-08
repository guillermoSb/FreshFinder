//
//  GroceryListStore.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/4/23.
//

import Foundation
import Combine

class GroceryListStore: ObservableObject {
    
    @Published private(set) var groceryLists: [GroceryList] = []
    
    
    
    init(groceryLists: [GroceryList]) {
        self.groceryLists = groceryLists
    }
    

    // MARK: User Intents
    
    func addList(_ groceryList: GroceryList) {
        self.groceryLists.append(groceryList)
    }
    
    func deleteLists(at indexSet: IndexSet) {
        groceryLists.remove(atOffsets: indexSet)
    }
    
}
