//
//  PlacesSet.swift
//  fisu
//
//  Created by vm mac on 05/04/16.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class PlacesSet {
    
    var places: [Place]
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    init()
    {
        places = [Place]() // a PlacesSet is created as an empty Array of places

    }
    
    // This function gets all the places from the database
    func getAllPlaces()
    {
        // Create the request to seek in the Place table
        let fetchRequest = NSFetchRequest(entityName: "Place")
        
        // Create a sort descriptor object that sorts on the "name" property of the Core Data object
        let sortDescriptorName = NSSortDescriptor(key: "name", ascending: true)
        
        // Set the list of sort descriptors in the fetch request, so it includes the sort descriptor
        fetchRequest.sortDescriptors = [sortDescriptorName]
        
        do {
            if let fetchResults = try self.managedObjectContext.executeFetchRequest(fetchRequest) as? [Place] {
                self.places = fetchResults  // Retrieve the results from the query into the Place Table
            }
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
        
    }
    
    // This function gets all the restaurants from the database
    func getAllRestaurants()
    {
        
        // Create the request to seek in the Place table
        let fetchRequest = NSFetchRequest(entityName: "Place")
        
        // Create a sort descriptor object that sorts on the "name" property of the Core Data object
        let sortDescriptorName = NSSortDescriptor(key: "name", ascending: true)
        
        // Set the list of sort descriptors in the fetch request, so it includes the sort descriptor
        fetchRequest.sortDescriptors = [sortDescriptorName]
        
        // Create a new predicate that filters out any object that has a category name containing "restaurant".
        let predicate = NSPredicate(format: "placeCategory.name CONTAINS[cd] %@", "restaurant")
        
        // Set the predicate on the fetch request
        fetchRequest.predicate = predicate
        
        do {
            if let fetchResults = try self.managedObjectContext.executeFetchRequest(fetchRequest) as? [Place] {
                self.places = fetchResults  // Retrieve the results from the query into the Place Table
            }
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
    }
    
    // This function adds a Place into the PlaceSet (if the Place isn't already in the PlaceSet)
    func addPlace(place: Place)
    {
        if(!exists(place))
        {
            self.places.append(place)
        }
    }
    
    // This function checks if a Place is already in the PlaceSet
    func exists(place: Place) -> Bool
    {
        var i: Int = 0
        var find: Bool = false
        while(i < self.places.count && !find) // While we didn't scan all the places and we didn't find the Place
        {
            if(place.name == self.places[i].name)   // We seek in the PlaceSet a Place with the same name
            {                                       // (we consider that the name of an Place defines it)
                find = true
            }
            i += 1
        }
        
        return find
    }
    
    // This function counts the number of places in the PlaceSet
    func count() -> Int
    {
        return self.places.count
    }
    
    // This function returns the Place located in the specified index of the PlaceSet
    func getPlace(index: Int) -> Place
    {
        return self.places[index]
    }
    
}
