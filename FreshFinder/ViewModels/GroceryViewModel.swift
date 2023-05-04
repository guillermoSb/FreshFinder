//
//  GroceryViewModel.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/19/23.
//

import Combine
import Foundation

class GroceryViewModel: ObservableObject {
    @Published private(set) var grocery: Grocery
    @Published private(set) var currentItem: GroceryListItem {
        didSet {
            UserDefaults.standard.set(currentItemIndex!, forKey: grocery.list._id.stringValue)
        }
    }
    
    var currentItemIndex: Int? {
        grocery.list.wrappedItems.firstIndex(of: currentItem)
    }
    
    var currentItemPurchased: Bool {
        return currentItem.purchased
    }
    
    init(with groceryList: GroceryList) {
        self.grocery = Grocery(list: groceryList, itemsPurchased: [])   // The list is empty at the beginning
        // Set the current item
        var currentItemFromDefaults = UserDefaults.standard.integer(forKey: groceryList._id.stringValue)
        if currentItemFromDefaults >= groceryList.items.count {
            currentItemFromDefaults = 0
        }
        currentItem = groceryList.items[currentItemFromDefaults]
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
    
    
    
    func nextItem() {
        guard let currentItemIndex else { return }
        if self.grocery.list.wrappedItems.hasNextItem(for: currentItemIndex) {
            currentItem = grocery.list.wrappedItems[currentItemIndex + 1]
        }
    }
    
    
    func prevItem() {
        guard let currentItemIndex else { return }
        if self.grocery.list.wrappedItems.hasPrevIndex(for: currentItemIndex) {
            currentItem = grocery.list.wrappedItems[currentItemIndex - 1]
        }
    }
    
    func editItem(_ item: GroceryListItem) {
        if let groceryItemFromRealm = Persistence.shared.realm.object(ofType: GroceryListItem.self, forPrimaryKey: currentItem._id) {
            try! Persistence.shared.realm.write {
                groceryItemFromRealm.name = item.name
                groceryItemFromRealm.price = item.price
                groceryItemFromRealm.measureUnit = item.measureUnit
                groceryItemFromRealm.quantity = item.quantity
            }
        }
    }

}
