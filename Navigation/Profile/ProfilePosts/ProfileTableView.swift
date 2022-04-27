//
//  ProfileHeaderView.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 10.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubViews()
    }

    private var statusText: String = ""
    private var statusTag: Bool = false
    private var errorSpace: Bool = false

    func addSubViews() {
        self.backgroundColor = .lightGray

        self.addSubview(avatar)
        let avatarTopAncor = avatar.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 16)
        let avatarLeadingAnchor = avatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let avatarWidthAnchor = avatar.widthAnchor.constraint(equalToConstant: 150)
        let avatarHeightAnchor = avatar.heightAnchor.constraint(equalToConstant: 150)

        self.addSubview(showButton)
        let showButtonTopAncor = showButton.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 16)
        let showButtonLeadingAnchor = showButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        let showButtonTrailingAnchor = showButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        let showButtonHeightAnchor = showButton.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        self.addSubview(nameLabel)
        let nameLabelWidthAnchor = nameLabel.widthAnchor.constraint(equalToConstant: 200)
        let nameLabelLeftAnchor = nameLabel.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 16)
        let nameLabelTopAnchor = nameLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 27)

        self.addSubview(statusLabel)
        let statusLabelWidthAnchor = statusLabel.widthAnchor.constraint(equalToConstant: 200)
        let statusLabelLeftAnchor = statusLabel.leftAnchor.constraint(equalTo: avatar.rightAnchor, constant: 16)
        let statusLabelBottomAnchor = statusLabel.bottomAnchor.constraint(equalTo: showButton.topAnchor, constant: -34)

        self.addSubview(warningLabel)
        let warningLabelTopAnchor = warningLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 1)
        let warningLabelLeftAnchor = warningLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor)
        let warningLabelRightAnchor = warningLabel.rightAnchor.constraint(equalTo: statusLabel.rightAnchor)
//        let warningLabelBottomAnchor = warningLabel.bottomAnchor.constraint(equalTo: showButton.topAnchor, constant: -34)
        self.addSubview(statusTextField)
        let statusTextFieldTopAnchor = statusTextField.bottomAnchor.constraint(equalTo: statusLabel.bottomAnchor)
        let statusTextFieldLeftAnchor = statusTextField.leftAnchor.constraint(equalTo: statusLabel.leftAnchor)
        let statusTextFieldRightAnchor = statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let statusTextFieldHeightAnchor = statusTextField.heightAnchor.constraint(equalToConstant: 40)

        NSLayoutConstraint.activate([avatarTopAncor, avatarLeadingAnchor, avatarWidthAnchor, avatarHeightAnchor,
                                    showButtonTopAncor, showButtonLeadingAnchor, showButtonTrailingAnchor, showButtonHeightAnchor,
                                    nameLabelWidthAnchor, nameLabelLeftAnchor, nameLabelTopAnchor,
                                     statusLabelWidthAnchor, statusLabelLeftAnchor, statusLabelBottomAnchor,
                                     warningLabelTopAnchor, warningLabelLeftAnchor, warningLabelRightAnchor,
                                     statusTextFieldTopAnchor, statusTextFieldLeftAnchor, statusTextFieldRightAnchor, statusTextFieldHeightAnchor
                                    ])
    }

    private lazy var showButton: UIButton = {
        let showButton = UIButton()
        showButton.setTitle("New status", for: .normal)
        showButton.setTitleColor(.white, for: .normal)
        showButton.setTitleColor(.systemGray, for: .selected)
        showButton.setTitleShadowColor(.systemMint, for: .normal)
        showButton.addTarget(self, action: #selector(TapShowButton), for: .touchUpInside)
        showButton.backgroundColor = .systemBlue
        showButton.layer.cornerRadius = 4.0
        showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.layer.shadowRadius = 4.0
        showButton.layer.shadowOpacity = 0.7
        showButton.setTitleShadowColor(.black, for: .normal)
        showButton.layer.shadowOffset = CGSize(width: 4, height: 4)

        return showButton
    }()


    private lazy var avatar: UIImageView = {
        let imageView = UIImageView (image: UIImage(named: "cat_photo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size = CGSize(width: 50, height: 50)
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 75.0
        imageView.clipsToBounds = true

        return imageView
    }()


    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18) // 24 лучше
        nameLabel.text = "Gentle cat"
        nameLabel.textColor = .black

        return nameLabel
    }()

    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.textAlignment = .left
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.font = UIFont.systemFont(ofSize: 17)
        statusLabel.text = "Waiting for miracle..."
        statusLabel.textColor = .darkGray

        return statusLabel
    }()

    private lazy var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.font = UIFont.systemFont(ofSize: 15)
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.textColor = .black
        statusTextField.backgroundColor = .white
        statusTextField.layer.cornerRadius = 12.0
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.borderWidth = 1.0
        statusTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        statusTextField.isHidden = true
        return statusTextField
    }()

    private lazy var warningLabel: UILabel = {
        let warningLabel = UILabel()
        warningLabel.textAlignment = .left
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        warningLabel.font = UIFont.boldSystemFont(ofSize: 12)
        warningLabel.text = "Поле не может быть пустым!"
        warningLabel.textColor = .systemRed
        warningLabel.isHidden = true
        return warningLabel
    }()

    private func theStatusTextField() {
        self.statusTextField.isHidden = false
        self.statusTextField.becomeFirstResponder() // Фокус на поле ввода.
    }


    private func statusTextChanged (statusTemp: String?){

        guard let statusTextTemp = statusTemp else { return }
        if statusTextTemp == "" {
            errorSpace = true
            statusTextField.layer.borderColor = UIColor.systemRed.cgColor
            statusTextField.layer.borderWidth = 2.0
            warningLabel.isHidden = false
            return
        } else {

            self.statusLabel.text = statusTextTemp
            errorSpace = false
        }

    }

    @objc private func TapShowButton () {
        if !statusTag {
            theStatusTextField()

            warningLabel.isHidden = true
            showButton.setTitle("Save status", for: .normal)

            statusTag.toggle()

        } else if statusTag {
            statusTextChanged(statusTemp: statusTextField.text)
            if !errorSpace {
                self.statusTextField.layer.borderColor = UIColor.black.cgColor
                self.statusTextField.layer.borderWidth = 1.0
                self.statusTextField.isHidden = true
                showButton.setTitle("New status", for: .normal)
                warningLabel.isHidden = true

                statusTag.toggle()
            }
        }
    }

}



