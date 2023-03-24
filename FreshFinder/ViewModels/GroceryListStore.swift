//
//  GroceryListStore.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/4/23.
//

import Combine
import CoreData

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
    

    // MARK: User Intents
    
    func addList(_ groceryList: GroceryList) {
        self.groceryLists.append(groceryList)
    }
    
    func deleteLists(at indexSet: IndexSet) {
        groceryLists.remove(atOffsets: indexSet)
    }
    
}
