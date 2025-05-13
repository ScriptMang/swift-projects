//
//  ViewController.swift
//  jsonCrashCourse
//
//  Created by Andy Peralta on 3/11/21.
//

import UIKit
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional fter loading the view.
       let filePath = Bundle.main.path(forResource:"TstScript", ofType: "txt")
       let fileURL = URL(fileURLWithPath: filePath ?? "Nothing")
       guard let dataPath = try? Data(contentsOf: fileURL) else {
            print("File failed to be read")
            return
        }
        print("fileURL: \(dataPath)")
        parse(dataPath)
    }


    func parse(_ data: Data) {
       let decoder = JSONDecoder()
       do {
            let arr = try decoder.decode([Key].self, from: data)
            let key = arr.first!
            print("Tile: \(key.title.rendered), content: \(key.content.rendered)")
        } catch {
          print("Json Decoding failed: \(error); Line 31")
        }
    }
}

