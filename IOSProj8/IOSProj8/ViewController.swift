//
//  ViewController.swift
//  IOSProj8
//
//  Created by Andy Peralta on 2/3/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var cluesLabel: UILabel!
  var answerLabel: UILabel!
  var currentAnswer: UITextField!
  var scoreLabel: UILabel!
  var letterButtons = [UIButton]()

  var activatedButtons = [UIButton]()
  var solns = [String]()

  var score = 0
  var level = 1
  var correctAnswers = 0

  override func loadView() {
    view = UIView()
    view.backgroundColor = .white

    scoreLabel = UILabel()
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    scoreLabel.textAlignment = .right
    scoreLabel.text = "Score: \(score)"
    view.addSubview(scoreLabel)

    cluesLabel = UILabel()
    cluesLabel.translatesAutoresizingMaskIntoConstraints = false
    cluesLabel.font = UIFont.systemFont(ofSize: 24)
    cluesLabel.text = "CLUES"
    cluesLabel.numberOfLines = 0
    cluesLabel.setContentHuggingPriority(
      UILayoutPriority(1), for: .vertical)
    view.addSubview(cluesLabel)

    answerLabel = UILabel()
    answerLabel.translatesAutoresizingMaskIntoConstraints = false
    answerLabel.font = UIFont.systemFont(ofSize: 24)
    answerLabel.textAlignment = .right
    answerLabel.text = "ANSWERS"
    answerLabel.numberOfLines = 0
    answerLabel.setContentHuggingPriority(
         UILayoutPriority(1), for: .vertical)
    view.addSubview(answerLabel)

    currentAnswer = UITextField()
    currentAnswer.translatesAutoresizingMaskIntoConstraints = false
    currentAnswer.placeholder = "Tap letter to guess"
    currentAnswer.textAlignment =  .center
    currentAnswer.font = UIFont.systemFont(ofSize: 44)
    currentAnswer.isUserInteractionEnabled = false
    view.addSubview(currentAnswer)

    let submit = UIButton(type: .system)
    submit.translatesAutoresizingMaskIntoConstraints = false
    submit.setTitle("SUBMIT", for: .normal)
    submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    view.addSubview(submit)

    let clear = UIButton(type: .system)
    clear.translatesAutoresizingMaskIntoConstraints = false
    clear.setTitle("CLEAR", for: .normal)
    clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
    view.addSubview(clear)

    let buttonsView = UIView()
    buttonsView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(buttonsView)

    NSLayoutConstraint.activate ([
      scoreLabel.topAnchor.constraint(
        equalTo: view.layoutMarginsGuide.topAnchor),
      scoreLabel.trailingAnchor.constraint(
        equalTo: view.layoutMarginsGuide.trailingAnchor),

      cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
      cluesLabel.leadingAnchor.constraint(equalTo:
        view.layoutMarginsGuide.leadingAnchor, constant: 100),
      cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),

      answerLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
      answerLabel.trailingAnchor.constraint(equalTo:
        view.layoutMarginsGuide.trailingAnchor, constant: -100),
      answerLabel.widthAnchor.constraint(equalTo:
        view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
      answerLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),

      currentAnswer.centerXAnchor.constraint(equalTo:
        view.centerXAnchor),
      currentAnswer.widthAnchor.constraint(equalTo:
        view.widthAnchor, multiplier: 0.5),
      currentAnswer.topAnchor.constraint(equalTo:
        cluesLabel.bottomAnchor, constant: 20),

      submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
      submit.centerXAnchor.constraint(equalTo:
        view.centerXAnchor, constant: -100),
      submit.heightAnchor.constraint(equalToConstant: 44),

      clear.centerXAnchor.constraint(equalTo:
        view.centerXAnchor, constant: 100),
      clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
      clear.heightAnchor.constraint(equalToConstant: 44),

      buttonsView.widthAnchor.constraint(equalToConstant: 750),
      buttonsView.heightAnchor.constraint(equalToConstant: 320),
      buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttonsView.topAnchor.constraint(equalTo:
        submit.bottomAnchor, constant: 20),
      buttonsView.bottomAnchor.constraint(equalTo:
        view.layoutMarginsGuide.bottomAnchor, constant: -20),
    ])

    let width = 150
    let height = 80

    for row in 0..<4 {
      for column in 0..<5 {
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        letterButton.setTitle("WWW", for: .normal)
        letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)

        let frame = CGRect(x: column * width,
          y: row * height, width: width, height: height)
        letterButton.frame = frame

        buttonsView.addSubview(letterButton)
        letterButtons.append(letterButton)

      }
    }

    buttonsView.layer.borderWidth = 1
    buttonsView.layer.borderColor  = UIColor.gray.cgColor
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    loadLevel()
    // Do any additional setup after loading the view.
  }

  @objc func letterTapped(_ sender: UIButton) {
    guard let buttonTitle = sender.titleLabel?.text else {return}

    currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
    activatedButtons.append(sender)
//    sender.isHidden = true

    sender.alpha = 0
  }

  @objc func submitTapped(_ sender: UIButton) {
    guard let answerText = currentAnswer.text else {return}



    if let solutionPosition = solns.firstIndex(of: answerText) {
      activatedButtons.removeAll()

       correctAnswers += 1

      var splitAnswers = answerLabel.text?.components(separatedBy: "\n")

      splitAnswers?[solutionPosition] = answerText
      answerLabel.text = splitAnswers?.joined(separator: "\n")
      currentAnswer.text = ""

      score += 1

      if correctAnswers % 7 == 0 && score != 0 {
        let ac = UIAlertController(title:
          "Well Done!", message: "Are you ready for the next level?",
          preferredStyle: .alert)
        ac.addAction(UIAlertAction(title:
          "Lets go!", style: .default, handler: levelUp))
        present(ac, animated: true)
      }
    } else {
       score -= 1
      let ac = UIAlertController(title: "Incorrect Answer", message: " Please Try again", preferredStyle: .alert)

      ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: {
        action in
        self.clearTapped(sender)
      }))
      present(ac, animated: true)
    }
    scoreLabel.text? = " Score: \(score)"
  }

  func levelUp(action: UIAlertAction) {
    level += 1
    correctAnswers = 0

    solns.removeAll(keepingCapacity: true)
    loadLevel()

    for button in letterButtons {
      button.isHidden = false
    }
  }

  @objc func clearTapped(_ sender: UIButton) {
    currentAnswer.text = ""

    for button in activatedButtons {
      button.alpha = 1
    }

    activatedButtons.removeAll()
  }

  func loadLevel() {
    var clueStr  = ""
    var solnStr = ""
    var letterBits = [String]()

    if let levelFileURL  = Bundle.main.url(forResource:
      "level\(level)", withExtension: "txt") {
      if let levelContents = try? String(contentsOf: levelFileURL) {
        var lines = levelContents.components(separatedBy: "\n")
        lines.shuffle()

        for (index, line) in lines.enumerated() {
          let parts = line.components(separatedBy: ": ")
          let answer = parts[0]
          let clue = parts[1]

          clueStr += "\(index + 1), \(clue)\n"
          let solnWord = answer.replacingOccurrences(of: "|", with: "")
          solnStr += "\(solnWord.count) letters\n"
          solns.append(solnWord)

          let bits = answer.components(separatedBy: "|")
          letterBits += bits
        }
      }
    }

    cluesLabel.text = clueStr.trimmingCharacters(in: .whitespacesAndNewlines)
    answerLabel.text = solnStr.trimmingCharacters(in: .whitespacesAndNewlines)

    letterButtons.shuffle()

    if letterButtons.count == letterBits.count {
      for i in 0..<letterButtons.count {
        letterButtons[i].setTitle(letterBits[i], for: .normal)
      }
    }

  }
}

