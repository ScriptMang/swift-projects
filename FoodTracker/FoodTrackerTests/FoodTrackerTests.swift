//
//  FoodTrackerTestsTests.swift
//  FoodTrackerTestsTests
//
//  Created by Andy Peralta on 6/17/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
   //MARK: Meal Class Tests

   // Confirm that the Meal initializer returns a Meal object when passed valid parameters
   func testMealIntializationSucceeds()  {

    // Zero Rating
    let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
    XCTAssertNotNil(zeroRatingMeal)

    // Positive rating
    let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
    XCTAssertNotNil(positiveRatingMeal)
  }

    func testMealInitializationFails()  {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

      // Negative rating
      let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
      XCTAssertNil(negativeRatingMeal)

      // Rating exceeds maximum
      let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
      XCTAssertNil(largeRatingMeal)

      // Empty String
      let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
      XCTAssertNil(emptyStringMeal)
    }
}
