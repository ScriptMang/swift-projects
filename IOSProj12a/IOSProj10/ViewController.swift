//
//  ViewController.swift
//  IOSProj10
//
//  Created by Andy Peralta on 2/20/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  var people = [Person]()

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.leftBarButtonItem =
      UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    // Do any additional setup after loading the view.
  }


 override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  return people.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
      "Person", for: indexPath) as? PersonCell else {
        fatalError("Unable to dequeue PersonCell.")
    }

    let person = people[indexPath.item]
    cell.name.text = person.name

    let path = getDocumentsDirectory().appendingPathComponent(person.image)
    cell.imageView.image = UIImage(contentsOfFile: path.path)

    cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
    cell.imageView.layer.borderWidth = 2
    cell.imageView.layer.cornerRadius = 3
    cell.layer.cornerRadius = 7


    return cell
  }

  @objc func addNewPerson() {
    let picker = UIImagePickerController()
    picker.allowsEditing  = true
    picker.delegate = self
    present(picker, animated: true)
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return}

    let imageName = UUID().uuidString
    let imagePath =
      getDocumentsDirectory().appendingPathComponent(imageName)

    if let jpegData = image.jpegData(compressionQuality: 0.8) {
      try? jpegData.write(to: imagePath)
    }
    let person = Person(name: "Unknown", image: imageName)
    people.append(person)
    collectionView.reloadData()

    dismiss(animated: true)
  }

  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let person = people[indexPath.item]
    let ac2 = UIAlertController(title: "Delete or Rename Person", message: nil, preferredStyle: .alert)

    ac2.addAction(UIAlertAction(title: "Delete", style: .default) {
      [weak self] _ in
      self?.people.remove(at: indexPath.item)
      self?.collectionView.reloadData()
    })

    ac2.addAction(UIAlertAction(title: "Rename", style: .default) {
      [weak self] _ in
        let ac = UIAlertController(title: "Rename Person", message: nil, preferredStyle: .alert)

                ac.addTextField()

                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

                ac.addAction(UIAlertAction(title: "OK", style: .default) {
                  [weak ac] _ in
                  guard let newName = ac?.textFields?[0].text else {return}
                  person.name = newName

                  self?.collectionView.reloadData()
                })

      self?.present(ac, animated: true)
      })

     present(ac2, animated: true)
    }


  }

