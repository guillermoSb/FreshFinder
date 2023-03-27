//
//  Persistence.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/2/23.
//

import RealmSwift
import Realm

struct Persistence {
    static let shared = Persistence(inMemory: false)
    static private let identifier = "FreshFinderRealm"
    static private let version = 2
    let realm: Realm
    
    static let preview: Persistence = {
        let persistence = Persistence(inMemory: true)
        // Insert Dummy data
        let item1 = GroceryListItem(value: ["name": "Manzanas", "quantity": 2, "price": 0.25])
        let item2 = GroceryListItem(value: ["name": "Cereal", "quantity": 1, "price": 1.00])
        let list = GroceryList(value: ["name": "My Test List"])
        list.items.append(item1)
        list.items.append(item2)
        do {
            try persistence.realm.write {
                persistence.realm.add(list)
            }
        } catch {
            fatalError("Could not create preview data: \(error)")
        }
        return persistence
    }()
    
    private init(inMemory: Bool) {
        var config: Realm.Configuration
        if inMemory {
            config = Realm.Configuration(inMemoryIdentifier: Persistence.identifier)
        } else {
            config = Realm.Configuration(schemaVersion: UInt64(Persistence.version))
        }
        self.realm = try! Realm(configuration: config)
    }
}
