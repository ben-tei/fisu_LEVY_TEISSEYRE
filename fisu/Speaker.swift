//
//  Speaker.swift
//  fisu
//
//  Created by vm mac on 12/03/2016.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import Foundation
import CoreData


class Speaker: NSManagedObject {
    
    // This class function creates the Speaker in the database as a ManagedObjectContext
    class func createInManagedObjectContext(moc: NSManagedObjectContext, about: String, firstname: String, name: String, image: NSData) -> Speaker? {
        
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "Speaker")     // Create the request to seek in the Speaker Table
        let predicate : NSPredicate = NSPredicate(format: "name = %@ AND firstname = %@", name, firstname)                                                          // Create a new predicate to seek if another Speaker
                                                                                      // with the same name already exists.
        fetchRequest.predicate = predicate                                            // Set the predicate on the fetch request

        do {
            let result = try moc.executeFetchRequest(fetchRequest) as! [Speaker]      // Retrieve the results from the query into the Speaker Table)
            if result.count == 0 {                                                    // If there is no Activity with this name in the database, we can create it
                let newSpeaker = NSEntityDescription.insertNewObjectForEntityForName("Speaker", inManagedObjectContext: moc) as! Speaker
                newSpeaker.about = about
                newSpeaker.firstname = firstname
                newSpeaker.name = name
                newSpeaker.image = image
                
                return newSpeaker
            }
            else                                                                      // Else, the Speaker already exists, so we return it
            {
                return result[0]
            }
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
            return nil
        }
        
    }
    
}
