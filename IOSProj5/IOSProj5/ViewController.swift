//
//  ViewController.swift
//  IOSProj5
//
//  Created by Andy Peralta on 1/14/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  var allWords = [String]()
  var usedWords = [String]()


  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.rightBarButtonItem =
      UIBarButtonItem(barButtonSystemItem: .add,
      target: self, action: #selector(promptForAnswer))

    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      if let startWords = try? String(contentsOf: startWordsURL) {
        allWords = startWords.components(separatedBy: "\n")
      }
    }

    if allWords.isEmpty {
        allWords = ["silkWorm"]
    }

    startGame()

    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
  }

   @objc func startGame() {
      title = allWords.randomElement()
      usedWords.removeAll(keepingCapacity: true)
      tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView,
      numberOfRowsInSection section: Int) -> Int {
      return usedWords.count
    }


      override func tableView(_ tableView: UITableView,
          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text =  usedWords[indexPath.row]
        return cell
      }

  @objc func promptForAnswer() {
    let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
    ac.addTextField()

    let submitAction = UIAlertAction(title: "Submit", style: .default) {
      [weak self, weak ac] _ in
      guard let answer = ac?.textFields?[0].text else {return}
      self?.submit(answer)
    }

    ac.addAction(submitAction)
    present(ac, animated: true)
  }

  func submit (_ answer: String) {
    
    let lowerAnswer = answer.lowercased()

    if isPossible(word: lowerAnswer) {
      if isOriginal(word: lowerAnswer) {
        if isReal(word: lowerAnswer) {
          usedWords.insert(answer, at: 0)

          let indexPath = IndexPath(row: 0, section: 0)
          tableView.insertRows(at: [indexPath], with: .automatic)
          return

        } else {showErrorMessage(title: "Word not recognized", msg: "You can't jst make up, you know!")}
      } else {showErrorMessage(title: "Word already used", msg: "Be more original!")}
    } else {showErrorMessage(title: "Word not possible", msg: "You can't spell that word from \(title!.lowercased()).")}
  }

  func isPossible(word: String) -> Bool {
    guard var tempWord = title?.lowercased() else {return false}
    for letter in word {
      if let position = tempWord.firstIndex(of: letter) {
        tempWord.remove(at: position)
      } else { return false }
    }
    return true
  }

  func isOriginal(word: String) -> Bool {
    return !usedWords.contains(word)
  }

  func isReal(word: String) -> Bool {
    if word.count > 2 {
      let checker = UITextChecker()
      let range = NSRange(location: 0, length: word.utf16.count)
      let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

      return misspelledRange.location == NSNotFound
    }
    return false
  }

  func showErrorMessage(title: String, msg: String) -> Void {
    let ac = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }

    // Do any additional setup after loading the view.
  }




