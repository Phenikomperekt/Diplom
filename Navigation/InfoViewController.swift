//
//  InfoViewController.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 07.03.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var infoButton: UIButton = {
        let infoButton = UIButton()
        infoButton.setTitle("Info", for: .normal)
        infoButton.setTitleColor(.black, for: .normal)
        infoButton.setTitleColor(.systemGray, for: .selected)
        infoButton.setTitleShadowColor(.systemMint, for: .normal)
        infoButton.addTarget(self, action: #selector(TapAlertButton), for: .touchUpInside)
        infoButton.backgroundColor = .white
        infoButton.layer.cornerRadius = 12.0
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        return infoButton
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBlue

        self.view.addSubview(self.infoButton)
        self.infoButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -400).isActive = true
        self.infoButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.infoButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.infoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }


    @objc private func TapAlertButton () {
        let ac = AlertController(title: "Info", message: "Send me message:", preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
                print("The program is okay.")
            }

        let noAction = UIAlertAction(title: "No", style: .default) { (action) -> Void in
                print("The program is not okay.")
            }
        ac.addAction(yesAction)
        ac.addAction(noAction)

        self.present(ac, animated: true, completion: nil)


    }


}
