//
//  ViewController.swift
//  IOSProj1
//
//  Created by Andy Peralta on 1/6/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
var pictures = [String]()
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    title = "Storm Viewer"
    navigationController?.navigationBar.prefersLargeTitles = true

    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)
    for item in items {
      if item.hasPrefix("nssl"){
        pictures.append(item)
      }
    }
    pictures.sort()
    print(pictures)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail")
      as? DetailViewController {
      vc.selectedImage = pictures[indexPath.row]
      vc.selectedPict =  indexPath.row + 1
      vc.totalPicts = pictures.count
      navigationController?.pushViewController(vc, animated: true)
    }
  }

}




