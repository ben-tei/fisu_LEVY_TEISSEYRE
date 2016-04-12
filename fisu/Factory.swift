//
//  Factory.swift
//  fisu
//
//  Created by vm mac on 23/03/16.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Factory {
    
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func createPlaceCategory(name: String) -> PlaceCategory?
    {
        return PlaceCategory.createInManagedObjectContext(moc, name: name)
    }
    
    func createActivityCategory(name: String)  -> ActivityCategory?
    {
        return ActivityCategory.createInManagedObjectContext(moc, name: name)
    }
    
    func createPlace(address: String, latitude: String, longitude: String, name: String, placeCategory: PlaceCategory) -> Place?
    {
        return Place.createInManagedObjectContext(moc, address: address, latitude: latitude, longitude: longitude, name: name, placeCategory: placeCategory)
    }
    
    func createSpeaker(imageName: String, about: String, firstname: String, name: String) -> Speaker?
    {
        guard let image = UIImage(named: imageName) else {
            return nil
        }
        
        guard let imagePNG = UIImagePNGRepresentation(image) else {
            return nil
        }
        
        return Speaker.createInManagedObjectContext(moc, about: about, firstname: firstname, name: name, image: imagePNG)
    }
    
    func createActivity(name: String, summary: String, date: String, startTime: String, endTime: String, imageName: String, activityCategory: ActivityCategory, place: Place, speakers: NSSet, registered: Bool) -> Activity?
    {
        guard let image = UIImage(named: imageName) else {
            return nil
        }
        
        guard let imagePNG = UIImagePNGRepresentation(image) else {
            return nil
        }
        
        return Activity.createInManagedObjectContext(moc, name: name, summary: summary, date: date, startTime: startTime, endTime: endTime, image: imagePNG, activityCategory: activityCategory, place: place, speakers: speakers, registered: registered)
    }
    
    func createInManagedObjectContext()
    {
        // Create "Faculty" Category in Core Data
        guard let faculty = createPlaceCategory("Faculty") else {
            return
        }
        
        // Create "Korean Restaurant" Category in Core Data
        guard let koreanRestaurant = createPlaceCategory("Korean Restaurant") else {
            return
        }
        
        // Create "University Restaurant" Category in Core Data
        guard let universityRestaurant = createPlaceCategory("University Restaurant") else {
            return
        }
        
        // Create "Hotel" Category in Core Data
        guard let hotel = createPlaceCategory("Hotel") else {
            return
        }
        
        // Create "Sport" Activity Category in Core Data
        guard let sport = createActivityCategory("Sport") else {
            return
        }
        
        // Create "Academic" Activity Category in Core Data
        createActivityCategory("Academic")
        
        // Create "Cultural" Activity Category in Core Data
        guard let cultural = createActivityCategory("Cultural") else {
            return
        }
        
        // Create the Restaurant called "Grillad'Oc" in Core Data
        createPlace("11 rue de Verdun", latitude: "43.607362", longitude: "3.881563", name: "Grillad'Oc", placeCategory: koreanRestaurant)
        
        // Create the Restaurant called "Resto U Triolet" in Core Data
        createPlace("1061 Rue du Professeur Joseph Anglada", latitude: "43.631208", longitude: "3.862410", name: "Resto U Triolet", placeCategory: universityRestaurant)
        
        // Create the Hotel called "Hotel Les Troènes" in Core Data
        guard let lesTroenes = createPlace("17 Avenue Emile Bertin Sans", latitude: "43.629110", longitude: "3.863552", name: "Hotel Les Troènes", placeCategory: hotel) else {
            return
        }
        
        // Create the Hotel called "Hotel Le Saint-Eloi" in Core Data
        guard let leSaintEloi = createPlace("27 Avenue du Professeur Grasset", latitude: "43.624015", longitude: "3.867178", name: "Hotel Le Saint-Eloi", placeCategory: hotel) else {
            return
        }
        
        // Create the Faculty called "UM (Triolet)" in Core Data
        guard let um = createPlace("2 Place Eugène Bataillon", latitude: "43.631510", longitude: "3.861595", name: "UM (Triolet)", placeCategory: faculty) else {
            return
        }
        
        // Create the Faculty called "UFR - STAPS" in Core Data
        guard let ufr_staps = createPlace("700 Avenue du Pic Saint-Loup", latitude: "43.640792", longitude: "3.853919", name: "UFR - STAPS", placeCategory: faculty) else {
            return
        }
        
        // Create the Speaker called "Batman" in Core Data
        guard let batman = createSpeaker("batman", about: "I am the night...", firstname: "Bruce", name: "Wayne") else {
            return
        }
        
        // Create the Speaker called "Superman" in Core Data
        guard let superman = createSpeaker("superman", about: "Do you bleed ?", firstname: "Clark", name: "Kent") else {
            return
        }
        
        // Create the Speaker called "Serena Wiliams" in Core Data
        guard let williams = createSpeaker("williams", about: "Number Uno", firstname: "Serena", name: "Williams") else {
            return
        }
        
        // Create the Speaker called "Forrest Gump" in Core Data
        guard let forrestGump = createSpeaker("forrestGump", about: "Run Forrest ! Run !", firstname: "Forrest", name: "Gump") else {
            return
        }
        
        // Create the Speaker called "Sylvester Stallone" in Core Data
        guard let sylvesterStallone = createSpeaker("sylvesterStallone", about: "Adriaaaaaaaaaaan !", firstname: "Sylvester", name: "Stallone") else {
            return
        }
        
        // Create the Activity "How to play Foot" in Core Data
        createActivity("How to play Foot", summary: "It's gonna be so fun ! Zizou will be there !", date: "2016-06-18", startTime: "10:30", endTime: "11:30", imageName: "foot", activityCategory: sport, place: um, speakers: NSSet(array: [batman]), registered: false)
        
        // Create the Activity "How to play Tennis" in Core Data
        createActivity("How to play Tennis", summary: "Play tennis like Roger Federer :)", date: "2016-06-12", startTime: "08:00", endTime: "09:00", imageName: "tennis", activityCategory: sport, place: ufr_staps, speakers: NSSet(array: [superman, williams]), registered: true)
        
        // Create the Activity "How to Run" in Core Data
        createActivity("How to Run", summary: "Running is so easy, come with us !", date: "2016-06-15", startTime: "17:00", endTime: "19:00", imageName: "running", activityCategory: sport, place: lesTroenes, speakers: NSSet(array: [forrestGump]), registered: true)
        
        // Create the Activity "Rocky Movie" in Core Data
        createActivity("Rocky Movie", summary: "Down ! Down ! Stay Down !", date: "2016-06-15", startTime: "13:00", endTime: "15:00", imageName: "boxing", activityCategory: cultural, place: leSaintEloi, speakers: NSSet(array: [sylvesterStallone]), registered: false)
        
    }
    
}


