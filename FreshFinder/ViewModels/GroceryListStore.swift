//
//  GroceryListStore.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/4/23.
//

import Combine
import RealmSwift

class GroceryListStore: ObservableObject {
    private var viewContext: NSManagedObjectContext
  
    
    @Published private(set) var groceryLists: [GroceryList] = []
    
    
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        fetchGroceryLists()
    }
    
    
    public func createGroceryListItem() -> GroceryListItem {
        return GroceryListItem(context: viewContext)
    }
    
    public func createGroceryList() -> GroceryList {
        return GroceryList(context: viewContext)
    }
    
    public func createGroceryList(with items: [GroceryListItem], listName: String) {
        let newList = GroceryList(context: viewContext)
        newList.name = listName
        newList.item = NSSet(set: Set(items))
        saveContext()
        fetchGroceryLists() // TODO: Remove this
    }
    
    public func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
    
    
    private func fetchGroceryLists() {
        let request = GroceryList.fetchRequest()
        let results = try? viewContext.fetch(request)
        self.groceryLists = results ?? []
    }
    

    
    func addList(_ groceryList: GroceryList) {
        try! Persistence.shared.realm.write {
            Persistence.shared.realm.add(groceryList)
        }
    }
    
    
    func editList(_ groceryList: GroceryList, name: String, currency: Currency ,items: [GroceryListItem]) {
        let groceryListFromRealm = Persistence.shared.realm.object(ofType: GroceryList.self, forPrimaryKey: groceryList._id)
        if let groceryListFromRealm {
            try! Persistence.shared.realm.write {
                groceryListFromRealm.name = name
                groceryListFromRealm.currency = currency
                groceryListFromRealm.items.removeAll()
                for item in items {
                    let newItem = GroceryListItem(value: ["name": item.name, "price": item.price as Any, "quantity": item.quantity, "measureUnit": item.measureUnit, "purchased": item.purchased])
                    groceryListFromRealm.items.append(newItem)
                }
            }
        }
        
    }
    
    
    func toggleItemPurchased(_ item: GroceryListItem) {
        let groceryListItemFromRealm = Persistence.shared.realm.object(ofType: GroceryListItem.self, forPrimaryKey: item._id)
        if let groceryListItemFromRealm {
            try! Persistence.shared.realm.write {
                groceryListItemFromRealm.purchased.toggle()
            }
        }
    }
    
    
    func reset(_ groceryList: GroceryList) {
        let groceryListFromRealm = Persistence.shared.realm.object(ofType: GroceryList.self, forPrimaryKey: groceryList._id)
        if let groceryListFromRealm {
            try! Persistence.shared.realm.write {
                UserDefaults.standard.set(0, forKey: groceryList._id.stringValue)
                for item in groceryListFromRealm.items {
                    item.purchased = false
                }
            }
        }
    }
    
}
