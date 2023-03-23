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
        grocery.list.wrappedItems.firstIndex(of: currentItem)
    }
    
    var currentItemPurchased: Bool {
        return grocery.itemsPurchased.firstIndex(of: currentItem) != nil
    }
    
    init(with groceryList: GroceryList) {
        self.grocery = Grocery(list: groceryList, itemsPurchased: [])   // The list is empty at the beginning
        currentItem = groceryList.wrappedItems[0]
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
        self.currentItem = grocery.list.wrappedItems[0]
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

}
