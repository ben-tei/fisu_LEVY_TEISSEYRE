//
//  SpeakersSetTests.swift
//  fisu
//
//  Created by Dylan on 12/04/2016.
//  Copyright © 2016 BenjaminTeisseyre-DylanLevy. All rights reserved.
//

import XCTest
import UIKit
import CoreData

@testable import fisu

class SpeakersSetTests: XCTestCase {
    
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
    
    func testAddSpeaker() {
        let f = Factory()
        
        // Create the Speaker
        guard let testSpeaker = f.createSpeaker("batman", about: "Don't forget the invariant !", firstname: "Chris", name: "FIRE") else {
            return
        }
        
        let testSpeakersSet = SpeakersSet()
        
        testSpeakersSet.addSpeaker(testSpeaker)
        
        XCTAssertTrue(testSpeakersSet.exists(testSpeaker))
    
        // Create the Speaker again
        guard let testSpeaker2 = f.createSpeaker("batman", about: "We don't care about the invariant !", firstname: "Chris", name: "FIRE") else {
            return
        }
        
        testSpeakersSet.addSpeaker(testSpeaker2)
        
        guard let SpeakerGot : Speaker = testSpeakersSet.getSpeaker(0) else {
            return
        }
        
        XCTAssertFalse(SpeakerGot.about == ("We don't care about the invariant !"))
        
        XCTAssertTrue(testSpeakersSet.count() == 1)
        
    }
    
}
