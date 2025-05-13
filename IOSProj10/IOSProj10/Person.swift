//
//  Person.swift
//  IOSProj10
//
//  Created by Andy Peralta on 2/21/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit

class Person: NSObject {
  var name: String
  var image: String

  init(name: String, image: String) {
    self.name = name
    self.image = image
  }
}
