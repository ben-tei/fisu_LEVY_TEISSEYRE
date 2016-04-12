//
//  SpeakersSet.swift
//  fisu
//
//  Created by vm mac on 05/04/16.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class SpeakersSet {
    
    var speakers: [Speaker]
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    init()
    {
        speakers = [Speaker]() // a SpeakersSet is created as an empty Array of speakers
    }
    
    // This function adds a Speaker into the SpeakersSet (if the Speaker isn't already in the SpeakersSet)
    func addSpeaker(speaker: Speaker)
    {
        if(!exists(speaker))
        {
            self.speakers.append(speaker)
        }
    }
    
    // This function checks if a Speaker is already in the SpeakersSet
    func exists(speaker: Speaker) -> Bool
    {
        var i: Int = 0
        var find: Bool = false
        while(i < self.speakers.count && !find)         // While we didn't scan all the speakers and we didn't find the speaker

        {
            if(speaker.name == self.speakers[i].name && speaker.firstname == self.speakers[i].firstname)   // We seek in the SpeakersSet a Speaker with the same name and firstname
            {                                           // (we consider that the name of a Speaker defines it)

                find = true                             // If we find a Speaker in the SpeakersSet with the same name,
            }                                           // We can change the value of "find" to true
            i += 1
        }
        
        return find
    }
    
    // This function counts the number of speakers in the SpeakersSet
    func count() -> Int
    {
        return self.speakers.count
    }
    
    // This function returns the Speaker located in the specified index of the SpeakerSet
    func getSpeaker(index: Int) -> Speaker
    {
        return self.speakers[index]
    }
    
}
