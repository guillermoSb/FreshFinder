//
//  FreshFinderApp.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import SwiftUI

 @main
struct FreshFinderApp: App {
    var body: some Scene {
        WindowGroup {
            FFGroceryLists(groceryListStore: GroceryListStore())
                .environment(\.realm, Persistence.shared.realm)
        }
    }
}
