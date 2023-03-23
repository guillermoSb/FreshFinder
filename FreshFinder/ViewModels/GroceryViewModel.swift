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
    
    var currentItemIndex: Int? {
        grocery.list.items.firstIndex(of: currentItem)
    }
    
    var currentItemPurchased: Bool {
        return grocery.itemsPurchased.firstIndex(of: currentItem) != nil
    }
    
    init(with groceryList: GroceryList) {
        self.grocery = Grocery(list: groceryList, itemsPurchased: [])   // The list is empty at the beginning
        currentItem = groceryList.items[0]
    }
    
    func buy() {
        // Only add the item to the list if it is not there
        if grocery.itemsPurchased.firstIndex(of: currentItem) == nil {
            grocery.itemsPurchased.append(currentItem)
        }
        
    }
    
    func discard() {
        if let idx = grocery.itemsPurchased.firstIndex(of: currentItem) {
            grocery.itemsPurchased.remove(at: idx)
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
