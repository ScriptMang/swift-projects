//
//  RegisterScreenUI.swift
//  QuickDraw
//
//  Created by Andy Peralta on 7/12/21.
//

import UIKit

protocol RgsterAccUIDelegate: AnyObject {
    func sendNewAccountToServer(fields:[UITextField])
}

class RegisterAccountScreenUI: UIView {
      var delegate: RgsterAccUIDelegate

    private lazy var  bigTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "QuickDraw"
        label.font = UIFont(name: "Hiragino Mincho ProN W3", size: 40)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()

        return label
    }()

    private lazy var  emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.font = UIFont(name: "Hiragino Mincho ProN W3", size: 20)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()

        return label
    }()

    private lazy var  emailField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Enter your Email"
        txtField.textColor = .black
        txtField.textAlignment = .left
        txtField.layer.borderColor = UIColor.blue.cgColor
        txtField.layer.borderWidth = 1
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.font = UIFont(name: "Hiragino Mincho ProN W3", size:  20)
        UITextField.appearance().textColor = .label
        txtField.sizeToFit()

        return txtField
    }()

    //MARK: Email StackView
    private lazy var  emailStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [emailLabel, emailField])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.alignment = .leading
        stackview.spacing = 10

        return stackview
    }()

    private lazy var  userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "UserName:"
        label.font = UIFont(name: "Hiragino Mincho ProN W3", size: 20)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()


        return label
    }()

    private lazy var  userNameField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Enter your Username"
        txtField.textColor = .label
        txtField.textAlignment = .left
        txtField.layer.borderColor = UIColor.blue.cgColor
        txtField.layer.borderWidth = 1
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.font = UIFont(name: "Hiragino Mincho ProN W3", size:  20)
        txtField.sizeToFit()

        return txtField
    }()


    private lazy var  pswdLabel: UILabel = {
        let label = UILabel()
        label.text = "Password:"
        label.font = UIFont(name: "Hiragino Mincho ProN W3", size: 20)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()

        return label
    }()

    private lazy var  pswdField: UITextField = {
        let pswdFld = UITextField()
        pswdFld.placeholder = "Enter your Password"
        pswdFld.textColor = .label
        pswdFld.textAlignment = .left
        pswdFld.layer.borderColor = UIColor.blue.cgColor
        pswdFld.layer.borderWidth = 1
        pswdFld.translatesAutoresizingMaskIntoConstraints = false
        pswdFld.font = UIFont(name: "Hiragino Mincho ProN W3", size:  20)
        pswdFld.sizeToFit()

        return pswdFld
    }()

    //MARK: Username StackView
    private lazy var userStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [userNameLabel, userNameField])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.alignment = .leading
        stackview.spacing = 10

        return stackview
    }()

    private lazy var pswdStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [pswdLabel, pswdField])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.alignment = .leading
        stackview.spacing = 10

        return stackview
    }()


    private lazy var  birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Birthday:"
        label.font = UIFont(name: "Hiragino Mincho ProN W3", size: 20)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()

        return label
    }()

    private lazy var  birthdayField: UITextField = {
        let bdayField = UITextField()
        bdayField.placeholder = "DD/DD/YYYY"
        bdayField.textColor = .label
        bdayField.textAlignment = .left
        bdayField.layer.borderColor = UIColor.blue.cgColor
        bdayField.layer.borderWidth = 1
        bdayField.translatesAutoresizingMaskIntoConstraints = false
        bdayField.font = UIFont(name: "Hiragino Mincho ProN W3", size:  20)
        bdayField.sizeToFit()

        return bdayField
    }()

    private lazy var readTxtFieldButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Test", for: .normal)
        button.addTarget(self, action: #selector(printTxtFields), for: .touchDown)

        return button
    }()

    //MARK: Birthday StackView
    private lazy var   birthdayStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [birthdayLabel, birthdayField])
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.alignment = .leading
        stackview.spacing = 10
        stackview.isUserInteractionEnabled = true

        return stackview
    }()

    private func setupViews() {
        for sub in [ bigTitleLabel, userStackView, pswdStackView,
                    emailStackView,  birthdayStackView,  readTxtFieldButton] {
            sub.translatesAutoresizingMaskIntoConstraints = false
            addSubview(sub)
        }

        NSLayoutConstraint.activate([
            //MARK: UI Constraints
            bigTitleLabel.topAnchor.constraint(lessThanOrEqualTo: self.centerYAnchor, constant: -300),
            bigTitleLabel.leadingAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor, constant: -100),

            userStackView.topAnchor.constraint(equalTo:  bigTitleLabel.topAnchor, constant: 200),
            userStackView.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant: 50),

            pswdStackView.topAnchor.constraint(equalTo:  userStackView.topAnchor, constant: 32),
            pswdStackView.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant: 50),


            emailStackView.topAnchor.constraint(equalTo:  pswdStackView.topAnchor, constant: 32),
            emailStackView.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant: 50),

            birthdayStackView.topAnchor.constraint(equalTo:  emailStackView.topAnchor, constant: 32),
            birthdayStackView.leadingAnchor.constraint(equalTo:  self.leadingAnchor, constant: 50),

            readTxtFieldButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 100),
            readTxtFieldButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 200),
        ])

        clipsToBounds = true
    }

    override init(frame: CGRect) {
        delegate = RegisterAccountController()
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func printTxtFields() {
        delegate.sendNewAccountToServer(fields: [userNameField, pswdField, emailField, birthdayField])
    }



}
