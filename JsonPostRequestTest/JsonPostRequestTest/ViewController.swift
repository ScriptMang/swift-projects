//
//  ViewController.swift
//  JsonPostRequestTest
//
//  Created by Andy Peralta on 4/4/21.
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        performPostRequest()
        // Do any additional setup after loading the view.
    }

    lazy var session: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.allowsExpensiveNetworkAccess = false
        let url = URLSession(configuration: config, delegate: self, delegateQueue: .main)
        return url
    }()

    func performPostRequest() {
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "data.cityofnewyork.us"
        urlComp.path = "/resource/uq7m-95z8.json"
        var rqst = URLRequest(url: urlComp.url!)
        rqst.httpMethod = "POST"
        
    }
}

