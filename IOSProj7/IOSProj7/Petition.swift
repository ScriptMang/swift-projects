//
//  Petition.swift
//  IOSProj7
//
//  Created by Andy Peralta on 1/24/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import Foundation

struct Petition: Codable {
  var title: String
  var body: String
  var signatureCount: Int
}
