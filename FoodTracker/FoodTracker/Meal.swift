//
//  Meal.swift
//  FoodTracker
//
//  Created by Andy Peralta on 6/11/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//
import UIKit
import Foundation
import os.log
class Meal: NSObject, NSCoding {
//MARK: Properties

  var name: String = ""
  var photo: UIImage?
  var rating: Int = 0

//MARK: Archiving Paths
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")


//MARK: Types

  struct PropertyKey {
    static let name = "name"
    static let photo = "photo"
    static let rating = "rating"
  }

//MARK: Initialization
  init?(name: String, photo: UIImage?, rating: Int) {

    // Initialization should fail if there is no name or if the rating is negative
    guard !name.isEmpty else {
      return nil
    }

    // Rating must be [0-5]
    guard ((rating >= 0) && (rating <= 5)) else {
      return nil
    }

    // Initializes stored properties
    self.name = name
    self.photo = photo
    self.rating = rating
  }

  //MARK: NSCoding
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: PropertyKey.name)
    aCoder.encode(photo, forKey: PropertyKey.photo)
    aCoder.encode(rating, forKey: PropertyKey.rating)
  }

  required convenience init?(coder aDecoder: NSCoder) {
    // The name is required, If we cannot decode a name string,
   //  the initializer should fail
    guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
      os_log("Unable to decode the anme for a Meal object.", log: OSLog.default, type: .debug)
      return nil
    }
    let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
    let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)

    // Must call  the designated initializer
    self.init(name: name, photo: photo, rating: rating)
  }


}
