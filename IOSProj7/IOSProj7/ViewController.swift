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

    let urlStr: String

    if navigationController?.tabBarItem.tag == 0 {
       urlStr =
           "https://www.hackingwithswift.com/samples/petitions-1.json"
    } else {
      urlStr =
        "https://www.hackingwithswift.com/samples/petitions-2.json"
    }

    navigationItem.rightBarButtonItem =
      UIBarButtonItem(title: "Credits", style: .plain,
      target: self, action: #selector(credits))

    let filterButton =
      UIBarButtonItem(title: "Filter", style: .plain,
      target: self, action: #selector(filterPetitions))

    let resetButton =
    UIBarButtonItem(title: "Reset", style: .plain,
    target: self, action: #selector(resetList))

    navigationItem.leftBarButtonItems = [filterButton, resetButton]

    if let url = URL(string: urlStr) {
      if let data = try? Data(contentsOf: url) {

        parse(json: data)
        return
      }
    }
    showError()
    // Do any additional setup after loading the view.
  }

  func showError() {
    let ac = UIAlertController(title: "Loading error",
        message: "There was a problem loading the feed; please check your connection and try again.",
        preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }

  func parse(json: Data) {
    let decoder = JSONDecoder()

    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
      petitions = jsonPetitions.results
      filteredPetitions = petitions
      tableView.reloadData()
    } else {showError()}
  }

  @objc func credits() {
    let alertController = UIAlertController(title: "Credits",
        message: " WhiteHouse API", preferredStyle: .alert )
    alertController.addAction(UIAlertAction(title: "Continue", style: .cancel))
    present(alertController, animated: true)
  }

  @objc func filterPetitions(json: Data) {
     let ac =
      UIAlertController(title: "Filter Petitions",
      message: nil, preferredStyle: .alert )

     ac.addTextField()
     let filterAction = UIAlertAction(title: "Filter", style: .default) {
       [weak self, weak ac] _ in
       guard let filterWord = ac?.textFields?[0].text else {return}

       self?.showPetitions(for: filterWord)
      }

     ac.addAction(filterAction)
     present(ac, animated: true)
  }

  @objc func resetList(action: UIAlertAction) {
     filteredPetitions = petitions
     tableView.reloadData()
   }

  func showPetitions(for filter: String) {
    for ptn in petitions {
      if ptn.title.contains(filter) {
        filteredPetitions.append(ptn)
      }
    }
    tableView.reloadData()
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

