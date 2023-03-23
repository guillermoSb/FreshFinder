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
