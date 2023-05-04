//
//  List+Ext.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/26/23.
//

import RealmSwift

extension RealmSwift.List where Element == GroceryListItem {
    func budget() -> Double {
        self.reduce(0) { partialResult, item in
            partialResult + (item.price ?? 0) * Double(item.quantity)
        }
    }
    
    func hasNextItem(for index: Int) -> Bool {
        return self.count - 1 > index
    }
    
    func hasPrevIndex(for index: Int) -> Bool {
        return index > 0
    }
}
