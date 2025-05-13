//
//  Picture.swift
//  IOSProj1
//
//  Created by Andy Peralta on 3/2/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import Foundation
class Picture: NSObject {
  var  title: String
  var  image: String

  init(title: String, image: String){
    self.title = title
    self.image = image
  }
}
