//
//  ViewController.swift
//  IOSProj4
//
//  Created by Andy Peralta on 1/10/20.
//  Copyright © 2020 UGLYMUG. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
  var webView: WKWebView!
  var progressView: UIProgressView!
  var websites = ["apple.com", "hackingwithswift.com"]

  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }

  override func viewDidLoad() {
     super.viewDidLoad()

     navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))


    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

    let backward = UIBarButtonItem(title: "<-", style: .plain, target: webView, action: #selector(webView.goBack))
    let forward = UIBarButtonItem(title: "->", style: .plain, target: webView, action: #selector(webView.goForward))
    navigationItem.leftBarButtonItems = [backward, forward]

    progressView = UIProgressView(progressViewStyle: .default)
    progressView.sizeToFit()
    let progressButton = UIBarButtonItem(customView: progressView)

    toolbarItems = [progressButton, spacer, refresh]
    navigationController?.isToolbarHidden = false

    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

    let url = URL(string: "https://" + websites[0])!
    webView.load(URLRequest(url: url))
    webView.allowsBackForwardNavigationGestures = true
     // Do any additional setup after loading the view.
   }

  @objc func openTapped() {
    let ac = UIAlertController(title: "Open pagee...", message: nil, preferredStyle: .actionSheet)

    for website in websites {
      ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
    }

    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
    present(ac, animated: true)
  }

  func openPage(action: UIAlertAction) {
    let url = URL(string: "https://" + action.title!)!
    webView.load(URLRequest(url: url))
  }

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    title = webView.title
  }

  override func observeValue(forKeyPath keyPath: String?, of object: Any?,
           change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      progressView.progress = Float(webView.estimatedProgress)
    }
  }

  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
               decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url

    if websites.contains(url!.absoluteString) {
      if let host = url?.host {
        for website in websites {
          if host.contains(website) {
            decisionHandler(.allow)
            return
          }
        }
      }
    } else {
      let ac2 = UIAlertController(title: "This site can't be viewed",  message: nil, preferredStyle: .alert)
      present(ac2, animated: true)
    }

    decisionHandler(.cancel)
 }

}
