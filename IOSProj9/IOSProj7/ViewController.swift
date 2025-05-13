//
//  ViewController.swift
//  IOSProj7
//
//  Created by Andy Peralta on 1/24/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.

import UIKit

class ViewController: UITableViewController {
  var petitions  = [Petition]()
  var filteredPetitions = [Petition]()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem =

      UIBarButtonItem(title: "Credits", style: .plain,
        target: self, action: #selector(credits))

      let filterButton =
         UIBarButtonItem(title: "Filter", style: .plain,
         target: self, action: #selector(filterPetitions))

      let resetButton =
          UIBarButtonItem(title: "Reset", style: .plain,
          target: self, action: #selector( resetList))

      navigationItem.leftBarButtonItems = [filterButton, resetButton]
      let urlStr: String
         if navigationController?.tabBarItem.tag == 0 {
           urlStr =
           "https://www.hackingwithswift.com/samples/petitions-1.json"
         } else {
           urlStr =
           "https://www.hackingwithswift.com/samples/petitions-2.json"
         }

         if let url = URL(string: urlStr) {
              if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
              }
         }
    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)

  }

 @objc func showError() {
      let ac = UIAlertController(title: "Loading error",
      message: "There was a problem loading the feed; please check your connection and try again.",
      preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
  }

  func parse(json: Data) {
    let decoder = JSONDecoder()
    DispatchQueue.global().async {
      [weak self] in
       if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        self?.petitions = jsonPetitions.results
        self?.filteredPetitions = self?.petitions ?? [Petition]()
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
       } else {
         DispatchQueue.main.async {
         self?.showError()
       }
    }
   }
 }

  @objc func credits() {
    let alertController =
      UIAlertController(title: "Credits",
            message: " WhiteHouse API", preferredStyle: .alert )
    alertController.addAction(UIAlertAction(title: "Continue", style: .cancel))
    present(alertController, animated: true)
  }

  @objc func filterPetitions() {
    DispatchQueue.main.async {
      [weak self] in

      let ac =
      UIAlertController(title: "Filter Petitions",
      message: nil, preferredStyle: .alert )
      ac.addTextField()

      let filterAction = UIAlertAction(title: "Filter", style: .default) {
       [weak ac] _ in
       guard let filterWord = ac?.textFields?[0].text else {return}
        self?.showPetitions(for: filterWord)
      }

      ac.addAction(filterAction)
      self?.present(ac, animated: true)
   }
  }

  @objc func resetList(action: UIAlertAction) {
    filteredPetitions = petitions
    tableView.reloadData()
  }

  func showPetitions(for filter: String) {
    DispatchQueue.global().async{
    [weak self] in
      self?.filteredPetitions.removeAll()
      for ptn in self?.petitions ?? [Petition]() {
        if ptn.title.contains(filter) {
          self?.filteredPetitions.append(ptn)
        }
      }
      DispatchQueue.main.async{
        self?.tableView.reloadData()
      }
    }
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredPetitions.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    // let petition = petitions[indexPath.row]
    let petition = filteredPetitions[indexPath.row]
    cell.textLabel?.text = petition.title
    cell.detailTextLabel?.text =  petition.body

    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = petitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }

}

