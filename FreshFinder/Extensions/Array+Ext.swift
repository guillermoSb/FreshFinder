//
//  Array+Ext.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/7/23.
//

import Foundation


extension Array where Element == GroceryListItem {
    func budget() -> Double {
        self.reduce(0) { partialResult, item in
            partialResult + (item.price ?? 0) * Double(item.quantity)
        }
    }
}
