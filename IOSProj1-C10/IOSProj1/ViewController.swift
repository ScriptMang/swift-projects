//
//  ViewController.swift
//  IOSProj1
//
//  Created by Andy Peralta on 1/6/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController,
UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
//var pictures = [String]()
  var picts = [Picture]()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    title = "Storm Viewer"
    navigationController?.navigationBar.prefersLargeTitles = true

    DispatchQueue.global().async {
      [weak self] in
        let fm = FileManager.default
           let path = Bundle.main.resourcePath!
           let items = try! fm.contentsOfDirectory(atPath: path)
           var itemCount = 0
           for item in items {
             if item.hasPrefix("nssl"){
              itemCount += 1
              self?.picts.append(Picture(title: "Pict \(itemCount)", image: item ))
             }
           }

      for pict in (self?.picts)! {
        print(pict.title)
      }

        DispatchQueue.main.async {
          self?.collectionView.reloadData()
        }
    }
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return  picts.count
  }


  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
      "Picture", for: indexPath) as? PictureCell else {
        fatalError("Unable to dequeue PictureCell.")
    }
    let pict = picts[indexPath.item]
    cell.name.text = pict.title

    let path = getDocumentsDirectory().appendingPathComponent(pict.image)
    print("In Cell For Item at the Path is: \(path.path)")

    cell.imageView.image = UIImage(contentsOfFile: path.path)

       cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
       cell.imageView.layer.borderWidth = 2
       cell.imageView.layer.cornerRadius = 3
       cell.layer.cornerRadius = 7

    return cell
  }

  func getDocumentsDirectory() -> URL {
    let path = URL(fileURLWithPath: "/Users/andyperalta/code/Swift/IOSProj1-C10/IOSProj1/Content/")
    print("This is the path: \(path)")
    return path
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail")
      as? DetailViewController {
      vc.selectedImage = picts[indexPath.item].image
      vc.selectedPict =  indexPath.row + 1
      vc.totalPicts = picts.count
      navigationController?.pushViewController(vc, animated: true)
    }
  }
}




