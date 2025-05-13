//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Andy Peralta on 5/15/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit
import os.log


class MealViewController: UIViewController,
UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  //MARK: Properties
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  @IBOutlet weak var saveButton: UIBarButtonItem!

  var meal: Meal?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

     // Handle the textField's user input through callbacks
    nameTextField.delegate = self

    if let meal = meal {
      navigationItem.title = meal.name
      nameTextField.text = meal.name
      photoImageView.image = meal.photo
      ratingControl.rating = meal.rating
    }

    // Enable the save button only if the textfield has a valid meal name
    updateSaveButtonState()
  }

  //MARK: UITextFieldDelegate

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Hide KeyBoard
    textField.resignFirstResponder()
    return true
  }

  func textFieldDidBeginEditing(_ textField: UITextField) {
    // Disable the Save Button while editing
    saveButton.isEnabled = false
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    updateSaveButtonState()
    navigationItem.title = textField.text
  }

  //MARK: Navigation
  // This method lets you configure a view controller before it's presented

  @IBAction func cancel(_ sender: UIBarButtonItem) {
// Depending on style of presentation (modal or push presentation),
// this view controller needs to be dismissed in two different ways.
    let isPresentingInAddMealMode = presentingViewController is UINavigationController
    if isPresentingInAddMealMode {
        dismiss(animated: true)
    } else  if let owningNavigationController = navigationController{
      owningNavigationController.popViewController(animated: true)
    } else {
      fatalError("The MealViewController is not inside a navigation controller")
    }

  }



  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)

    //Configure the destination view controller only when the save button is pressed
    guard let button = sender as? UIBarButtonItem, button === saveButton else {
      os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
      return
    }

    let name = nameTextField.text ?? ""
    let photo = photoImageView.image
    let rating = ratingControl.rating
    meal = Meal(name: name, photo: photo, rating: rating)
  }

  //MARK: Actions
  @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {

    // Hide KeyBoard
    nameTextField.resignFirstResponder()

    //UIImagePickerController is a viewController that  lets a user pick media from their photo library.
    let imagePickerController = UIImagePickerController()

    //Only allow photos to be picked, not taken.
    imagePickerController.delegate = self
    present(imagePickerController, animated: true)
  }

//  @IBAction func setDefaultLabelText(_ sender: UIButton) {
//    mealNameLabel.text = "Default Text"
//  }

//MARK: UIImagePickerControllerDelegate
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    //Dismiss the picker if the user canceled
    dismiss(animated: true, completion: nil)
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    // The info dictionary may contain multiple  representations of the image. You want to use the original
    guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      else
    {
      fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
    }
      photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
}

//MARK: Private Methods
  private func updateSaveButtonState() {
    //Disable the Save button if the text field is empty
    let text = nameTextField.text ?? ""
    saveButton.isEnabled = !text.isEmpty
  }
}
