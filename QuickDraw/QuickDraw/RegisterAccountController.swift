//
//  RegisterAccountController.swift
//  QuickDraw
//
//  Created by Andy Peralta on 7/12/21.
//

import UIKit
import CryptoSwift
import Firebase
class RegisterAccountController: UIViewController, RgsterAccUIDelegate {

    private lazy var createAccountButton: UIButton = {
        let button =  UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(sendToProfilepage), for: .touchUpInside)
        button.backgroundColor = .blue

        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        print("ViewController2 is ready to go baby")
        let regstrScreenUI = RegisterAccountScreenUI(frame:
        CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))

        view.addSubview(regstrScreenUI)
        view.addSubview(createAccountButton)

        NSLayoutConstraint.activate([
            createAccountButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100),
            createAccountButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
        ])
        
    }



    @objc func sendToProfilepage() {
        let vc = HomePageVC()
        vc.view.backgroundColor = .systemBackground
        navigationController?.pushViewController(vc, animated: true)
    }


    private func encryptPassword(pswd: String) -> String {
        let p: Array<UInt8> = Array(pswd.utf8)
        let salt: Array<UInt8> = Array( "Mambo".utf8)
        guard let key =
        try? PKCS5.PBKDF2.init(password: p, salt: salt, iterations: 4096, keyLength: 32, variant: .sha256).calculate() else {return " "}

        return key.toHexString()
    }

      func sendNewAccountToServer(fields: [UITextField]) {
           let db = Firestore.firestore()
           let hashed = encryptPassword(pswd: fields[1].text!)
           var docRef: DocumentReference? = nil
           docRef = db.collection("Users").addDocument(data: [
            "UserName":  fields[0].text!,
                "Password":  hashed,
                "Email":     fields[2].text! ,
                "Birthday":  fields[3].text!
            ]){ error in
                if let err = error {
                    print("Error Document: \(err)")
                } else {
                    print("Document Id: \(docRef!.documentID)")
                }
            }
        }
    }
