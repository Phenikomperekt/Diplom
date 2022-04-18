//
//  LogInView.swift
//  Navigation
//
//  Created by Evgeny Mastepan on 23.03.2022.
//

import UIKit

class LogInView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addLogInElements()
    }

    func addLogInElements() {
        self.backgroundColor = .white

        self.addSubview(logo)
        let logoTopAncor = logo.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 120)
        let logoCenterAnchor = logo.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let logoWidthAnchor = logo.widthAnchor.constraint(equalToConstant: 100)
        let logoHeightAnchor = logo.heightAnchor.constraint(equalToConstant: 100)

        self.addSubview(loginStackView)
        let loginTopAnchor = loginStackView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120)
        let loginLeftAnchor = loginStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
        let loginRightAnchor = loginStackView.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor, constant: -16)
        let loginHeightAnchor = loginStackView.heightAnchor.constraint(equalToConstant: 100)

        self.addSubview(logInButton)
        let buttonTopAnchor = logInButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 16)
        let buttonLeftAnchor = logInButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
        let buttonRightAnchor = logInButton.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor, constant: -16)
        let buttonHeightAnchor = logInButton.heightAnchor.constraint(equalToConstant: 50)



        NSLayoutConstraint.activate([
                                     logoTopAncor, logoCenterAnchor, logoWidthAnchor, logoHeightAnchor,
                                     loginTopAnchor, loginLeftAnchor, loginRightAnchor, loginHeightAnchor,
                                     buttonTopAnchor, buttonLeftAnchor, buttonRightAnchor, buttonHeightAnchor
                                    ])

    }

    private lazy var logo: UIImageView = {
        let logo = UIImageView (image: UIImage(named: "logo"))
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.frame.size = CGSize(width: 100, height: 100)
        logo.clipsToBounds = true

        return logo
    }()

    private func textFieldAttributes (text: UITextField) {
        text.backgroundColor = .systemGray6
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 16)
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: text.frame.height))
        text.leftViewMode = .always
        text.tintColor = .red
        text.layer.borderColor = UIColor.lightGray.cgColor
        text.layer.borderWidth = 0.5

    }


    private lazy var loginText: UITextField = {
        let loginText = UITextField()
        textFieldAttributes(text: loginText)
        loginText.attributedPlaceholder = NSAttributedString (
            string: "Email or phone",
            attributes: [NSAttributedString.Key.foregroundColor:  UIColor.lightGray])
        loginText.becomeFirstResponder()

        return loginText
    }()

    private lazy var passwordText: UITextField = {
        let passwordText = UITextField()
        textFieldAttributes(text: passwordText)
        passwordText.attributedPlaceholder = NSAttributedString (
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor:  UIColor.lightGray])
        passwordText.isSecureTextEntry = true

        return passwordText
    }()

    private lazy var loginStackView: UIStackView = {
        let loginStackView = UIStackView()
        loginStackView.axis = .vertical
        loginStackView.spacing = 0.0
        loginStackView.alignment = .fill
        loginStackView.distribution = .fillEqually
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        loginStackView.layer.borderColor = UIColor.lightGray.cgColor
        loginStackView.layer.borderWidth = 0.5
        loginStackView.layer.cornerRadius = 10.0
        loginStackView.layer.masksToBounds = true
        loginStackView.spacing = 0.5

        loginStackView.insertArrangedSubview(loginText, at: 0)
        loginStackView.insertArrangedSubview(passwordText, at: 1)

        return loginStackView
    }()
    

    private lazy var logInButton: UIButton = {
        let logInButton = UIButton()
        let image = UIImage(named: "blue_pixel")

        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.backgroundColor = .tintColor
        logInButton.setBackgroundImage(image, for: .normal)
        logInButton.setImage(image?.copy(alpha: 1.0), for: .normal)
        logInButton.setImage(image?.copy(alpha: 0.8), for: .selected)
        logInButton.setImage(image?.copy(alpha: 0.8), for: .highlighted)
        logInButton.setImage(image?.copy(alpha: 0.8), for: .disabled)
        logInButton.clipsToBounds = true
        logInButton.layer.cornerRadius = 10.0
        logInButton.addTarget(self, action: #selector(logInButtonTouch), for: .touchUpInside)

        return logInButton
    }()

    @objc func logInButtonTouch() {

        if let tabBarController = self.window!.rootViewController as? UITabBarController {
            tabBarController.tabBar.isHidden = false
        }
        
    }
    
}
