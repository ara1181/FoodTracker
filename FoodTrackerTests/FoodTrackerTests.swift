//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Colin Horsford on 9/12/16.
//  Copyright © 2016 Paerdegat. All rights reserved.
//

import XCTest
//@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    // MARK: FoodTracker Tests
    
    //Tests to confirm that the Meal intitalizer returns when no name or a negative rating is provided
    func testMealInitialization() {
        //Success case
        let potentialItem = Meal(name: "Newest meal", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        //XCTAssertNotNil tests that the Meal object is not nil after initialization
        
        //Failure cases
        let noName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        //this case should fail because the rating is negative
        let badRating = Meal(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating)
        
    }
    
}
