//
//  SplashViewController.swift
//  Diplom
//
//  Created by Evgeny Mastepan on 15.04.2022.
//

import UIKit

class TestViewController: UIViewController {

    var timer: Timer?

    private var logoSize: CGFloat {self.view.bounds.width / 3}

    private lazy var centerLogo: UIImageView = {
        let centerLogo = UIImageView(image:UIImage(named: "logo"))
        centerLogo.contentMode = .scaleAspectFill
        centerLogo.clipsToBounds = true
        centerLogo.layer.cornerRadius = logoSize / 2
        centerLogo.translatesAutoresizingMaskIntoConstraints = false
        return centerLogo
    }()

    private lazy var namedLabel: UILabel = {
        let namedLabel = UILabel()
        namedLabel.text = "ВКожуре."
        namedLabel.textColor = .white
        namedLabel.textAlignment = .center
        namedLabel.font = UIFont.boldSystemFont(ofSize: 26)
        namedLabel.translatesAutoresizingMaskIntoConstraints = false
        return namedLabel
    }()

    private lazy var subLabel: UITextField = {
        let namedLabel = UITextField()
        namedLabel.text = ""
        namedLabel.textColor = .black
        namedLabel.backgroundColor = .white

//        namedLabel.numberOfLines = 2
        namedLabel.textAlignment = .center
        namedLabel.font = UIFont.boldSystemFont(ofSize: 24)
        namedLabel.translatesAutoresizingMaskIntoConstraints = false
        return namedLabel
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


    func setGradientBackground() {
        let colorTop = UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(centerLogo)
        self.view.addSubview(namedLabel)
        self.view.addSubview(subLabel)
        self.view.addSubview(logInButton)

        let constraintsOfAll = self.constraintsOfAll()
        NSLayoutConstraint.activate(constraintsOfAll)



    }

    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(animated)
    }

    func constraintsOfAll() -> [NSLayoutConstraint] {
        let centerLogoHeight = centerLogo.heightAnchor.constraint(equalToConstant: logoSize)
        let centerLogoWidth = centerLogo.widthAnchor.constraint(equalToConstant: logoSize)
        let centerLogoX = centerLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let centerLogoY = centerLogo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50)
        let namedLabelX = namedLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let namedLabelBottom = namedLabel.topAnchor.constraint(equalTo: self.centerLogo.bottomAnchor, constant: logoSize)
        let subLabelTop = subLabel.topAnchor.constraint(equalTo: namedLabel.bottomAnchor, constant: 20)
        let subLabelX = subLabel.centerXAnchor.constraint(equalTo: centerLogo.centerXAnchor)
        let subLabelLeft = subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        let subLabelRight = subLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)

        let butLabelTop = logInButton.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 20)
        let butLabelX = logInButton.centerXAnchor.constraint(equalTo: centerLogo.centerXAnchor)
        let butLabelLeft = logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        let butLabelRight = logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)


        return [
            centerLogoHeight, centerLogoWidth, centerLogoX, centerLogoY,
            namedLabelX, namedLabelBottom,
            subLabelTop, subLabelX, subLabelLeft, subLabelRight,
            butLabelTop, butLabelX, butLabelLeft, butLabelRight
               ]
    }

    @objc func logInButtonTouch() {

        guard let login = subLabel.text else {
            print ("Пустой нил")
            return
        }
        let validator = EmailValidator(input: login)
        if validator.isValid {
            print ("Проверка пройдета")
            namedLabel.text = login
        } else {
            print ("Не пройдета")
        }



    }

}
