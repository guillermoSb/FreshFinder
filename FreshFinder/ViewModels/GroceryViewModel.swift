//
//  GroceryViewModel.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/19/23.
//

import Combine

class GroceryViewModel: ObservableObject {
    @Published private(set) var grocery: Grocery
    @Published private(set) var currentItem: GroceryListItem
    @Published private var hi = false
    
    var currentItemIndex: Int? {
        grocery.list.items.firstIndex(of: currentItem)
    }
    
    var currentItemPurchased: Bool {
        return currentItem.purchased
    }
    
    init(with groceryList: GroceryList) {
        self.grocery = Grocery(list: groceryList, itemsPurchased: [])   // The list is empty at the beginning
        currentItem = groceryList.items[0]
    }
    
    func buy() {
        if grocery.itemsPurchased.firstIndex(of: currentItem) == nil {
            let groceryListItemFromRealm = Persistence.shared.realm.object(ofType: GroceryListItem.self, forPrimaryKey: currentItem._id)
            if let groceryListItemFromRealm {
                try! Persistence.shared.realm.write {
                    groceryListItemFromRealm.purchased = true
                }
            }
        }
        
    }
    
    func discard() {
        if grocery.itemsPurchased.firstIndex(of: currentItem) == nil {
            let groceryListItemFromRealm = Persistence.shared.realm.object(ofType: GroceryListItem.self, forPrimaryKey: currentItem._id)
            if let groceryListItemFromRealm {
                try! Persistence.shared.realm.write {
                    groceryListItemFromRealm.purchased = false
                }
            }
        }
    }
    
    
    
    func finish() {
        self.currentItem = grocery.list.items[0]
    }
    
    
    func nextItem() {
        guard let currentItemIndex else { return }
        if self.grocery.list.items.hasNextItem(for: currentItemIndex) {
            currentItem = grocery.list.items[currentItemIndex + 1]
        }
    }
    
    
    func prevItem() {
        guard let currentItemIndex else { return }
        if self.grocery.list.items.hasPrevIndex(for: currentItemIndex) {
            currentItem = grocery.list.items[currentItemIndex - 1]
        }
    }

}
