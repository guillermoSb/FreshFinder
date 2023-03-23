//
//  GroceryListItem+CoreDataProperties.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/23/23.
//
//

import Foundation
import CoreData


extension GroceryListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryListItem> {
        return NSFetchRequest<GroceryListItem>(entityName: "GroceryListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: Int32
    @NSManaged public var price: Double
    
    public var wrappedName: String {
        name ?? "Unnamed"
    }
    
    public var wrappedQuantity: Int {
        Int(quantity)
    }
    
    public var wrappedPrice: Double {
        price
    }

}

extension GroceryListItem : Identifiable {

}
