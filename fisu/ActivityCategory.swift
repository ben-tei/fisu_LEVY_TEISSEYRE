//
//  ActivityCategory.swift
//  fisu
//
//  Created by vm mac on 12/03/2016.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import Foundation
import CoreData


class ActivityCategory: NSManagedObject {
    
    // This class function creates the Activity Category in the database as a ManagedObjectContext
    class func createInManagedObjectContext(moc: NSManagedObjectContext, name: String) -> ActivityCategory? {
        
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "ActivityCategory")  // Create the request to seek in the Activity Category table
        let predicate : NSPredicate = NSPredicate(format : "name = %@", name)               // Create a new predicate to seek if another Activity Category
                                                                                            // with the same name already exists.
        fetchRequest.predicate = predicate                                                  // Set the predicate on the fetch request
        do {
            let result = try moc.executeFetchRequest(fetchRequest) as! [ActivityCategory]   // Retrieve the results from the query
                                                                                            // into the Activity Category Table
            if result.count == 0 {                                                          // If there is no Activity Category with this name
                                                                                            // in the database, we can create it
                let newActivityCategory = NSEntityDescription.insertNewObjectForEntityForName("ActivityCategory", inManagedObjectContext: moc) as! ActivityCategory
                newActivityCategory.name = name
                
                return newActivityCategory                                                  // Else, the Activity Category already exists, so we return it
            }
            else
            {
                return result[0]                                                            
            }
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
            return nil
        }
        
    }
    
}
