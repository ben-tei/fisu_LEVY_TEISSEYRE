//
//  Activity.swift
//  fisu
//
//  Created by vm mac on 12/03/2016.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Activity: NSManagedObject {
    
    // This class function creates the Activity in the database as a ManagedObjectContext
    class func createInManagedObjectContext(moc: NSManagedObjectContext, name: String, summary: String, date: String, startTime: String, endTime: String, image: NSData, activityCategory: ActivityCategory, place: Place, speakers: NSSet, registered: NSNumber) -> Activity? {
        
        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "Activity")  // Create the request to seek in the Activity Table
        let predicate : NSPredicate = NSPredicate(format : "name = %@", name)       // Create a new predicate to seek if another Activity
                                                                                    // with the same name already exists.
        fetchRequest.predicate = predicate                                          // Set the predicate on the fetch request
        do {
            let result = try moc.executeFetchRequest(fetchRequest) as! [Activity]   // Retrieve the results from the query into the Activity Table
            if result.count == 0 {                                                  // If there is no Activity with this name in the database, we can create it
                let newActivity = NSEntityDescription.insertNewObjectForEntityForName("Activity", inManagedObjectContext: moc) as! Activity
                newActivity.summary = summary
                newActivity.date = date
                newActivity.endTime = endTime
                newActivity.image = image
                newActivity.name = name
                newActivity.startTime = startTime
                newActivity.activityCategory = activityCategory
                newActivity.place = place
                newActivity.speakers = speakers
                newActivity.registered = registered
                
                return newActivity
            }
            else                                                                    // Else, the Activity already exists, so we return it
            {
                return result[0]
            }
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
            return nil
        }
        
    }
    
    // This function is used when a user (de)registers to an activity. It sets the Activity chosen as registered (or not)
    func register(wantsToRegister: NSNumber)
    {
        if wantsToRegister == true {
            self.setValue(true, forKey: "registered")       // If the user wants to register, we set the Activity "registered" boolean to true.
        } else {
            self.setValue(false, forKey: "registered")      // If the user wants to deregister, we set the Activity "registered" boolean to false.
        }
        
        guard let moc = self.managedObjectContext else {    // Get the ManagedObjectContext
            return
        }
        
        if moc.hasChanges {                                 // Save the modifications if necessary
            do {
                try moc.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
        
    }
    
}
