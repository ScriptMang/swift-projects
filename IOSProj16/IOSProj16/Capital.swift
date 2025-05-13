//
//  Capital.swift
//  IOSProj16
//
//  Created by Andy Peralta on 4/15/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit
import MapKit
class Capital: NSObject, MKAnnotation {
  var title: String?
  var coordinate: CLLocationCoordinate2D
  var info: String?

 init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
    self.title = title
    self.coordinate = coordinate
    self.info = info
  }
}
