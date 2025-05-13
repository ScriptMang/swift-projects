//
//  ViewController.swift
//  IOSProj2
//
//  Created by Andy Peralta on 1/7/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!
  var countries = [String]()
  var score = 0
  var correctAnswer = 0
  var totalQuestions = 0


  override func viewDidLoad() {
    super.viewDidLoad()
     navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                        target: self, action: #selector(shareTapped))
    countries += ["estonia", "france", "germany", "ireland", "italy",
                  "monaco","nigeria", "poland","russia","spain", "uk", "us"]

    button1.layer.borderWidth = 1
    button1.layer.borderColor = UIColor.lightGray.cgColor


    button2.layer.borderWidth = 1
    button2.layer.borderColor = UIColor.lightGray.cgColor

    button3.layer.borderWidth = 1
    button3.layer.borderColor = UIColor.lightGray.cgColor

    askQuestion()
  }

  func askQuestion(action: UIAlertAction! = nil) {
    countries.shuffle()
    totalQuestions += 1
    correctAnswer = Int.random(in: 0...2)
    button1.setImage(UIImage(named: countries[0]), for: .normal)
    button2.setImage(UIImage(named: countries[1]), for: .normal)
    button3.setImage(UIImage(named: countries[2]), for: .normal)
    title = countries[correctAnswer].uppercased() + "  Score: \(score)      TotalQuestions: \(totalQuestions)"
  }

  @IBAction func buttonTapped(_ sender: UIButton) {
    var title: String
   UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 4, initialSpringVelocity: 5, options: [],
            animations: {
              switch sender {
              case self.button1:
                self.button1.imageView?.transform = CGAffineTransform(scaleX: 1, y:  2)

                print("I'm the first button\n")

              case self.button2:
                self.button2.imageView?.transform = CGAffineTransform(scaleX: 1, y:  2)
                print("I'm the second button\n")

              case self.button3:
                self.button3.imageView?.transform = CGAffineTransform(scaleX: 1, y:  2)
                print("I'm the third button\n")


             default:
                 break
             }
   }) { finished in
    self.button1.imageView?.transform = .identity
    self.button2.imageView?.transform = .identity
    self.button3.imageView?.transform = .identity
    }


    if sender.tag == correctAnswer {
      title = "Correct"
      score += 1
    } else {
      title = "Wrong thats the flag of \(countries[correctAnswer])"
      score -= 1
    }



    if totalQuestions == 10 {
        let ac = UIAlertController(title: title,
        message: "GameOver FinalScore is \(score)", preferredStyle: .alert)
        present(ac, animated: true)
    } else {
      let ac = UIAlertController(title: title,
      message: "Your score is \(score)", preferredStyle: .alert)

      ac.addAction(UIAlertAction(title: "Continue",
      style: .default, handler: askQuestion))

      present(ac, animated: true)
    }
  }

  @objc func shareTapped() {
       let vc = UIActivityViewController(activityItems: ["Current Score: " + String(score)],
           applicationActivities: [])
       vc.popoverPresentationController?.barButtonItem =
       navigationItem.rightBarButtonItem
       present(vc, animated: true)
  }
}

