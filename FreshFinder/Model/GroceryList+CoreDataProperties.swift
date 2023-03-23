//
//  GroceryList+CoreDataProperties.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/23/23.
//
//

import Foundation
import CoreData


extension GroceryList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryList> {
        return NSFetchRequest<GroceryList>(entityName: "GroceryList")
    }

    @NSManaged public var name: String?
    @NSManaged public var item: NSSet?
    
    
    public var wrappedName: String {
        name ?? "Unnamed"
    }
    
    public var wrappedItems: [GroceryListItem] {
        let set = item as? Set<GroceryListItem> ?? []
        return Array(set)
    }
    
    
    static var example: GroceryList {
        let context = PersistenceController.preview.container.viewContext
        let fetchRequest: NSFetchRequest<GroceryList> = GroceryList.fetchRequest()
        fetchRequest.fetchLimit = 1
        let results = try? context.fetch(fetchRequest)
        return (results?.first!)!
    }

}

extension GroceryList : Identifiable {

}
