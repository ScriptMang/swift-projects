//
//  ViewController.swift
//  QuickDraw
//
//  Created by Andy Peralta on 6/8/21.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {

    private lazy var  registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create account", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pushtoRegisterPage), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let loginView = LoginScreenUI(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
        view.addSubview(registerButton)

        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loginView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            loginView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            loginView.widthAnchor.constraint(equalTo: self.view.widthAnchor),

            registerButton.leadingAnchor.constraint(equalTo:  self.view.leadingAnchor, constant: 100),
            registerButton.topAnchor.constraint(equalTo:  self.view.topAnchor, constant: 450),
        ])
    }

    @objc func pushtoRegisterPage() {
       let registerAccountVc = RegisterAccountController()
        view.backgroundColor = .systemBackground
        self.navigationController?.pushViewController(registerAccountVc, animated: false)
    }
}
