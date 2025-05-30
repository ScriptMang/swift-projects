//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Andy Peralta on 6/3/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

  //MARK: Properties
  var meal: Meal?


  private var ratingButtons = [UIButton]()
  var rating = 0 {
    didSet {
      updateButtonSelectionStates()
    }
  }

  @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
    didSet {
      setupButtons()
    }
  }

  @IBInspectable var starCount: Int = 5 {
    didSet {
      setupButtons()
    }
  }

  //MARK: Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButtons()
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)
    setupButtons()
  }

  //MARK: Button Action
  @objc func ratingButtonTapped(button: UIButton) {
    guard let index = ratingButtons.firstIndex(of: button) else {
      fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
    }

    // Calculate the rating of the selected button
    let selectedRating = index + 1

    if selectedRating == rating {
      // If the selected star represents the current rating, reset the rating 0
      rating = 0

    } else {
      // Otherwise set the rating to the selected star
      rating = selectedRating
    }
  }

  //MARK: Private Methods
  private func setupButtons() {

    //clear any existing buttons
    for button in ratingButtons {
      removeArrangedSubview(button)
      button.removeFromSuperview()
    }
    ratingButtons.removeAll()

    // Load Buttons Images
    let bundle = Bundle(for: type(of: self))
    let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
    let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
    let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)


    for _ in 0..<starCount {

      //buttons created
      let button = UIButton()

      // Set the button images
      button.setImage(emptyStar, for: .normal)
      button.setImage(filledStar, for: .selected)
      button.setImage(highlightedStar, for: .highlighted)
      button.setImage(highlightedStar, for: [.highlighted, .selected])


      // constraints
      button.translatesAutoresizingMaskIntoConstraints = false
      button.heightAnchor.constraint(equalToConstant: starSize.height).isActive  = true
      button.widthAnchor.constraint(equalToConstant: starSize.width).isActive  = true

      //Setup the button action
      button.addTarget(self, action: #selector(ratingButtonTapped), for: .touchUpInside)

      // Add the button to the stack
      addArrangedSubview(button)

      // Add the new button to the rating button array
      ratingButtons.append(button)
    }
    updateButtonSelectionStates()
  }

  private func updateButtonSelectionStates() {
    for (index, button) in ratingButtons.enumerated() {
      // If the index of a button is less
      // than the rating, that button should be selected
      button.isSelected = index < rating
    }
  }
}
