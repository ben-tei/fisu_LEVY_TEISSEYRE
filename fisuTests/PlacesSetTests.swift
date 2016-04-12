//
//  PlacesSetTests.swift
//  fisu
//
//  Created by Dylan on 12/04/2016.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import XCTest
import UIKit
import CoreData

@testable import fisu

class PlacesSetTests: XCTestCase {
    
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
    
    func testAddPlace() {
        let f = Factory()
        
        // Create "Test Restaurant" Category
        guard let testRestaurantCategory = f.createPlaceCategory("Test Restaurant") else {
            return
        }
        
        // Create the Restaurant
        guard let testRestaurant = f.createPlace("42 Experiment Street", latitude: "42.000000", longitude: "4.200000", name: "Testy... Tasty, Testy, do you understand ? LOL PTDR XPTDR... Sorry !", placeCategory: testRestaurantCategory) else {
            return
        }
        
        let testPlacesSet = PlacesSet()
        
        testPlacesSet.addPlace(testRestaurant)
        
        XCTAssertTrue(testPlacesSet.exists(testRestaurant))
        
        // Create the Restaurant again
        guard let testRestaurant2 = f.createPlace("10 Not the same address Street", latitude: "42.000000", longitude: "4.200000", name: "Testy... Tasty, Testy, do you understand ? LOL PTDR XPTDR... Sorry !", placeCategory: testRestaurantCategory) else {
            return
        }
        
        testPlacesSet.addPlace(testRestaurant2)
        
        guard let placeGot : Place = testPlacesSet.getPlace(0) else {
            return
        }
        
        XCTAssertFalse(placeGot.address == ("10 Not the same address Street"))
        
        XCTAssertTrue(testPlacesSet.count() == 1)
        
    }
    
}
