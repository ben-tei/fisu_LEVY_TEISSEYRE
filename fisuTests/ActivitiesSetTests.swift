//
//  ActivitiesSetTests.swift
//  fisu
//
//  Created by Dylan on 08/04/2016.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import XCTest
import UIKit
import CoreData

@testable import fisu

class ActivitiesSetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAddActivity() {
        let f = Factory()
        
        // Create "Faculty" Category in Core Data
        guard let faculty = f.createPlaceCategory("Faculty") else {
            return
        }
        
        // Create "Sport" Activity Category in Core Data
        guard let sport = f.createActivityCategory("Sport") else {
            return
        }
        
        // Create the Faculty called "UM (Triolet)" in Core Data
        guard let um = f.createPlace("2 Place Eugène Bataillon", latitude: "43.631510", longitude: "3.861595", name: "UM (Triolet)", placeCategory: faculty) else {
            return
        }
        
        // Create the Speaker called "Sylvester Stallone" in Core Data
        guard let sylvesterStallone = f.createSpeaker("sylvesterStallone", about: "Adriaaaaaaaaaaan !", firstname: "Sylvester", name: "Stallone") else {
            return
        }
        
        // Create the Activity "How to Test an App" in Core Data
        let testActivity = f.createActivity("How to Test an App", summary: "Because we love testing things !", date: "2016-04-27", startTime: "11:30", endTime: "13:30", imageName: "boxing", activityCategory: sport, place: um, speakers: NSSet(array: [sylvesterStallone]), registered: false)
        
        let testActivitiesSet = ActivitiesSet()
        
        guard let activity = testActivity else {
            return
        }
        
        testActivitiesSet.addActivity(activity)
        
        XCTAssertTrue(testActivitiesSet.exists(activity))
        
        // Create the Activity again
        let testActivity2 = f.createActivity("How to Test an App", summary: "The Second One, because we always want more tests !", date: "2016-04-27", startTime: "11:30", endTime: "13:30", imageName: "boxing", activityCategory: sport, place: um, speakers: NSSet(array: [sylvesterStallone]), registered: false)
        
        guard let activity2 = testActivity2 else {
            return
        }
        
        testActivitiesSet.addActivity(activity2)
        
        guard let activityGot : Activity = testActivitiesSet.getActivity(0) else {
            return
        }
        
        XCTAssertFalse(activityGot.summary == ("The Second One, because we always want more tests !"))
        
        XCTAssertTrue(testActivitiesSet.count() == 1)
        
        activity.register(true)
        
        XCTAssertTrue(activity.registered == true)
    
    }
    
}
