//
//  ActionViewController.swift
//  Extension
//
//  Created by Andy Peralta on 5/6/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
  @IBOutlet var script: UITextView!
  var pageTitle = ""
  var pageURL  = ""

  override func viewDidLoad() {
        super.viewDidLoad()

    navigationItem.rightBarButtonItem =
      UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))

    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(adjustForkeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
     notificationCenter.addObserver(self, selector: #selector(adjustForkeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

      if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
          if let itemProvider = inputItem.attachments?.first {
              itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in

                // do stuff!
                guard let itemDictionary =   dict as? NSDictionary else { return }
                guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }

                self?.pageTitle =  javaScriptValues["title"] as? String ?? ""
                self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                print(javaScriptValues)

                DispatchQueue.main.async {
                  self?.title = self?.pageTitle
                }
              }
          }
      }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text ?? "Default Value"]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]

        extensionContext?.completeRequest(returningItems: [item])
    }

  @objc func adjustForkeyboard(notification: Notification) {

    guard let keyboardVal =
      notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        as? NSValue else { return }

    let keyboardScreenEndFrame = keyboardVal.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

    if notification.name == UIResponder.keyboardWillHideNotification {
      script.contentInset = .zero
    } else {
      script.contentInset =
        UIEdgeInsets(top: 0, left: 0,
          bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
    }

    script.scrollIndicatorInsets = script.contentInset

    let selectedRange = script.selectedRange
    script.scrollRangeToVisible(selectedRange)
  }


}
