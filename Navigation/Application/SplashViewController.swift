//
//  SplashViewController.swift
//  Diplom
//
//  Created by Evgeny Mastepan on 15.04.2022.
//

import UIKit

class SplashViewController: UIViewController {

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

    private lazy var subLabel: UILabel = {
        let namedLabel = UILabel()
        namedLabel.text = "Социальная сеть для интровертов, социофобов и социопатов."
        namedLabel.textColor = .white
        namedLabel.numberOfLines = 2
        namedLabel.textAlignment = .center
        namedLabel.font = UIFont.boldSystemFont(ofSize: 14)
        namedLabel.translatesAutoresizingMaskIntoConstraints = false
        return namedLabel
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

        let constraintsOfAll = self.constraintsOfAll()
        NSLayoutConstraint.activate(constraintsOfAll)

        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.splashTimeOut), userInfo: nil, repeats: false)
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

        return [
            centerLogoHeight, centerLogoWidth, centerLogoX, centerLogoY,
            namedLabelX, namedLabelBottom,
            subLabelTop, subLabelX, subLabelLeft, subLabelRight
               ]
    }

    @objc func splashTimeOut() {
         if timer != nil {
             timer?.invalidate()
             dismiss(animated: true, completion: nil)
             let vc = TabBarController()
             vc.navigationItem.hidesBackButton = true
             navigationController?.pushViewController(vc, animated: false)
         }
    }

}
