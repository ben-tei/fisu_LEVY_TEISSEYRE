//
//  PlaceCategory.swift
//  fisu
//
//  Created by vm mac on 12/03/2016.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import Foundation
import CoreData


class PlaceCategory: NSManagedObject {
    
    // This class function creates the Place Category in the database as a ManagedObjectContext
    class func createInManagedObjectContext(moc: NSManagedObjectContext, name: String) -> PlaceCategory? {
        
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "PlaceCategory")     // Create the request to seek in the Place Category Table
        let predicate : NSPredicate = NSPredicate(format : "name = %@", name)               // Create a new predicate to seek if another Place Category
                                                                                            // with the same name already exists.
        fetchRequest.predicate = predicate                                                  // Set the predicate on the fetch request
        do {
            let result = try moc.executeFetchRequest(fetchRequest) as! [PlaceCategory]      // Retrieve the results from the query into the Place Category Table
            if result.count == 0 {                                                          // If there is no Place Category with this name in the database, we can create it
                let newPlaceCategory = NSEntityDescription.insertNewObjectForEntityForName("PlaceCategory", inManagedObjectContext: moc) as! PlaceCategory
                newPlaceCategory.name = name
                
                return newPlaceCategory
            }
            else
            {
                return result[0]                                                            // Else, the Activity already exists, so we return it
            }
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
            return nil
        }
        
    }
    
}
