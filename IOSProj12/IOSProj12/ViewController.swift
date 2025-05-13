//
//  ViewController.swift
//  IOSProj12
//
//  Created by Andy Peralta on 3/10/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let defaults = UserDefaults.standard
    defaults.set(25, forKey: "Age")
    defaults.set(true, forKey: "UseTouchID")
    defaults.set(CGFloat.pi, forKey: "Pi")

    defaults.set("Paul Hudson", forKey: "Name")
    defaults.set(Date(), forKey: "LastRun")

    var array = ["Hello", "World"]
    defaults.set(array, forKey: "SavedArray")
    defaults.set("Paul Hudson", forKey: "Name")

    let dict = ["Name": "Paul", "Country": "UK"]
    defaults.set(dict, forKey: "savedDict")
    // Do any additional setup after loading the view.

    array = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
  }


}

