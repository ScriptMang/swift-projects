//
//  ViewController.swift
//  IOSProj13
//
//  Created by Andy Peralta on 3/17/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//
import CoreImage
import UIKit



enum  imageParsingError: Error {
  case nilInput
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var intensity: UISlider!
  @IBOutlet var filterButton: UIButton!
  @IBOutlet var radius: UISlider!
  var currImage: UIImage!
  var context : CIContext!
  var currFilter: CIFilter!
  var filterTitle: String?

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "YACIFP"
    context = CIContext()
    currFilter = CIFilter(name: "CISepiaTone")
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
  }

  @IBAction func changeFilter(_ sender: UIButton) {
    let ac = UIAlertController(title: "Choose Filter", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler:{
      action in
      self.filterTitle = action.title
      self.filterButton.setTitle(self.filterTitle, for: .normal)
      self.setFilter(action)
    }))
     ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: {
       action in
       self.filterTitle = action.title
       self.filterButton.setTitle(self.filterTitle, for: .normal)
       self.setFilter(action)
     }))
     ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: {
       action in
       self.filterTitle = action.title
       self.filterButton.setTitle(self.filterTitle, for: .normal)
       self.setFilter(action)
     }))
     ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: {
      action in
      self.filterTitle = action.title
      self.filterButton.setTitle(self.filterTitle, for: .normal)
      self.setFilter(action)
     }))
     ac.addAction(UIAlertAction(title: "CITwirlDistortion ", style: .default, handler: {
       action in
       self.filterTitle = action.title
       self.filterButton.setTitle(self.filterTitle, for: .normal)
       self.setFilter(action)
     }))
     ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: {
       action in
      self.filterTitle = action.title
      self.filterButton.setTitle(self.filterTitle, for: .normal)
      self.setFilter(action)
     }))
     ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: {
       action in
       self.filterTitle = action.title
       self.filterButton.setTitle(self.filterTitle, for: .normal)
       self.setFilter(action)
     }))
     ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

       if let popOverController = ac.popoverPresentationController {
         popOverController.sourceView = sender
         popOverController.sourceRect = sender.bounds
       }
       present(ac, animated: true)
  }


  func setFilter(_ action: UIAlertAction) {
    guard currImage != nil else {return}

//    guard let actionTitle = action.title else {return}
    currFilter = CIFilter(name: action.title!)

    let beginImage = CIImage(image: currImage)
    currFilter.setValue(beginImage, forKey: kCIInputImageKey)

    applyProcessing()
  }

  @IBAction func save(_ sender: Any) {
    guard let image = imageView.image else { print("Error Could'nt Save Image; Image not Found: \(imageParsingError.nilInput)"); return}
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
  }

  @IBAction func intensityChanged(_ sender: Any) {
    applyProcessing()
  }

  @objc func importPicture() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated:true)
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else {return}
    dismiss(animated: true)
    currImage = image

    let beginImage = CIImage(image: currImage)
    currFilter.setValue(beginImage, forKey: kCIInputImageKey)
    applyProcessing()
  }

  func applyProcessing() {

    let inputKeys = currFilter.inputKeys
    if inputKeys.contains(kCIInputIntensityKey) {currFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)}
//    if inputKeys.contains(kCIInputRadiusKey) {currFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey)}
if inputKeys.contains(kCIInputRadiusKey) {currFilter.setValue(radius.value * 200, forKey: kCIInputRadiusKey)}
    if inputKeys.contains(kCIInputScaleKey) {currFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)}
    if inputKeys.contains(kCIInputCenterKey) {
      currFilter.setValue(CIVector(
        x: currImage.size.width / 2,
        y: currImage.size.height / 2),
        forKey: kCIInputCenterKey)
    }

    if let cgimg = context.createCGImage(currFilter.outputImage!, from: currFilter.outputImage!.extent) {
        let processedImage = UIImage(cgImage: cgimg)
        self.imageView.image = processedImage
    }
  }

  @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
        // we got back an error!
        let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    } else {
        let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
  }

}

