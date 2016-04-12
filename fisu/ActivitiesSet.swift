//
//  ActivitiesSet.swift
//  fisu
//
//  Created by vm mac on 05/04/16.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class ActivitiesSet {
    
    var activities: [Activity]
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    init()
    {
        activities = [Activity]() // an ActivitiesSet is created as an empty Array of activities
    }
    
    // This function is used when a user wants to get all the activities he registered to.
    func getMyActivities()
    {
        
        // Create the request to seek in the Activity table
        let fetchRequest = NSFetchRequest(entityName: "Activity")
        
        // Create a sort descriptor object that sorts on the "date", then on the "startTime" and finally on the "name" property of the Core Data object
        let sortDescriptorDate = NSSortDescriptor(key: "date", ascending: true)
        let sortDescriptorTime = NSSortDescriptor(key: "startTime", ascending: true)
        let sortDescriptorName = NSSortDescriptor(key: "name", ascending: true)
        
        // Set the list of sort descriptors in the fetch request, so it includes the sort descriptor
        fetchRequest.sortDescriptors = [sortDescriptorDate, sortDescriptorTime, sortDescriptorName]
        
        // Create a new predicate that filters out any object that has the registered boolean to true.
        let predicate = NSPredicate(format: "registered == TRUE")
        
        // Set the predicate on the fetch request
        fetchRequest.predicate = predicate
        
        do {
            if let fetchResults = try self.managedObjectContext.executeFetchRequest(fetchRequest) as? [Activity] {
                self.activities = fetchResults  // Retrieve the results from the query into the ActivitiesSet
            }
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
        
    }
    
    // This function gets all the activities from the database
    func getAllActivities()
    {
        // Create the request to seek in the Activity table
        let fetchRequest = NSFetchRequest(entityName: "Activity")
        
        // Create a sort descriptor object that sorts on the "date", then on the "startTime" and finally on the "name" property of the Core Data object
        let sortDescriptorDate = NSSortDescriptor(key: "date", ascending: true)
        let sortDescriptorTime = NSSortDescriptor(key: "startTime", ascending: true)
        let sortDescriptorName = NSSortDescriptor(key: "name", ascending: true)
        
        // Set the list of sort descriptors in the fetch request, so it includes the sort descriptor
        fetchRequest.sortDescriptors = [sortDescriptorDate, sortDescriptorTime, sortDescriptorName]
        
        do {
            if let fetchResults = try self.managedObjectContext.executeFetchRequest(fetchRequest) as? [Activity] {
                self.activities = fetchResults  // Retrieve the results from the query into the Activity Table
            }
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
        
    }
    
    // This function adds an Activity into the ActivitiesSet (if the Activity isn't already in the ActivitiesSet)
    func addActivity(activity: Activity)
    {
        if(!exists(activity))
        {
            self.activities.append(activity)
        }
    }
    
    // This function checks if an Activity is already in the ActivitiesSet
    func exists(activity: Activity) -> Bool
    {
        var i: Int = 0
        var find: Bool = false
        while(i < self.activities.count && !find) // While we didn't scan all the activities and we didn't find the activity
        {
            if(activity.name == self.activities[i].name)    // We seek in the ActivitiesSet an Activity with the same name
            {                                               // (we consider that the name of an Activity defines it)
                find = true                                 // If we find an Activity in the ActivitiesSet with the same name,
            }                                               // We can change the value of "find" to true
            i += 1
        }
        
        return find
    }
    
    // This function counts the number of activities in the ActivitiesSet
    func count() -> Int
    {
        return self.activities.count
    }
    
    // This function returns the Activity located in the specified index of the ActivitiesSet
    func getActivity(index: Int) -> Activity
    {
        return self.activities[index]
    }
    
}
