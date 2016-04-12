//
//  Place.swift
//  fisu
//
//  Created by vm mac on 12/03/2016.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import Foundation
import CoreData


class Place: NSManagedObject {
    
    // This class function creates the Place in the database as a ManagedObjectContext
    class func createInManagedObjectContext(moc: NSManagedObjectContext, address: String, latitude: String, longitude: String, name: String, placeCategory: PlaceCategory) -> Place? {
        
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "Place") // Create the request to seek in the Place table
        let predicate : NSPredicate = NSPredicate(format : "name = %@", name)   // Create a new predicate to seek if another Place
                                                                                // with the same name already exists.
        fetchRequest.predicate = predicate                                      // Set the predicate on the fetch request
        do {
            let result = try moc.executeFetchRequest(fetchRequest) as! [Place]  // Retrieve the results from the query into the Place Table
            if result.count == 0 {                                              // If there is no Place with this name in the database, we can create it
                let newPlace = NSEntityDescription.insertNewObjectForEntityForName("Place", inManagedObjectContext: moc) as! Place
                newPlace.address = address
                newPlace.latitude = latitude
                newPlace.longitude = longitude
                newPlace.name = name
                newPlace.placeCategory = placeCategory
                
                return newPlace
            }
            else                                                                // Else, the Place already exists, so we return it
            {
                return result[0]
            }
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
            return nil
        }
        
    }
    
}
