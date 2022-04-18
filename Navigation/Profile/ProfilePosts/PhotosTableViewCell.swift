//
//  PhotosTableViewCell.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 07.04.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    var photoWidth:CGFloat {(contentView.bounds.width-48)/4}
    
    private lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.backgroundColor = .white
        return mainView
    }()

    private lazy var topStackView: UIStackView = {
        let topStackView = UIStackView()
        topStackView.axis = .horizontal
        topStackView.backgroundColor = .white
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        return topStackView
    }()

    private lazy var downStackView: UIStackView = {
        let downStackView = UIStackView()
        downStackView.axis = .horizontal
        downStackView.backgroundColor = .white
        downStackView.alignment = .top
        downStackView.distribution = .fillEqually
        downStackView.spacing = 8
        downStackView.translatesAutoresizingMaskIntoConstraints = false
        return downStackView
    }()

    private lazy var photosLabel: UILabel = {
        let photosLabel = UILabel()
        let font: UIFont = UIFont.boldSystemFont(ofSize: 24)
        photosLabel.font = font
        photosLabel.textColor = .black
        photosLabel.text = "Photos"
        photosLabel.numberOfLines = 0
        photosLabel.sizeToFit()
        photosLabel.translatesAutoresizingMaskIntoConstraints = false
        return photosLabel
    }()

    private lazy var rightLabel: UIImageView = {
        let rightLabel = UIImageView()
        rightLabel.image = UIImage(systemName: "arrow.right")
        rightLabel.backgroundColor = .white
        rightLabel.sizeToFit()
        rightLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        rightLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        rightLabel.translatesAutoresizingMaskIntoConstraints = false

        return rightLabel
    }()

    private lazy var photo1: UIImageView = {
        let photo1 = UIImageView()
        photo1.image = UIImage(named: "1")
        photo1.contentMode = .scaleAspectFit
        photo1.backgroundColor = .black
        photo1.heightAnchor.constraint(equalToConstant: photoWidth).isActive = true
        photo1.widthAnchor.constraint(equalToConstant: photoWidth).isActive = true
//        photo1.translatesAutoresizingMaskIntoConstraints = false
        photo1.layer.cornerRadius = 6
        return photo1
    }()

    private lazy var photo2: UIImageView = {
        let photo2 = UIImageView()
        photo2.image = UIImage(named: "2")
        photo2.contentMode = .scaleAspectFit
        photo2.backgroundColor = .black
        photo2.heightAnchor.constraint(equalToConstant: photoWidth).isActive = true
        photo2.widthAnchor.constraint(equalToConstant: photoWidth).isActive = true
//        photo2.translatesAutoresizingMaskIntoConstraints = false
        photo2.layer.cornerRadius = 6
        return photo2
    }()

    private lazy var photo3: UIImageView = {
        let photo3 = UIImageView()
        photo3.image = UIImage(named: "3")
        photo3.contentMode = .scaleAspectFit
        photo3.backgroundColor = .black
        photo3.heightAnchor.constraint(equalToConstant: photoWidth).isActive = true
        photo3.widthAnchor.constraint(equalToConstant: photoWidth).isActive = true
//        photo3.translatesAutoresizingMaskIntoConstraints = false
        photo3.layer.cornerRadius = 6
        return photo3
    }()

    private lazy var photo4: UIImageView = {
        let photo4 = UIImageView()
        photo4.image = UIImage(named: "4")
        photo4.contentMode = .scaleAspectFit
        photo4.backgroundColor = .black
        photo4.heightAnchor.constraint(equalToConstant: photoWidth).isActive = true
        photo4.widthAnchor.constraint(equalToConstant: photoWidth).isActive = true
//        photo4.translatesAutoresizingMaskIntoConstraints = false
        photo4.layer.cornerRadius = 6
        return photo4
    }()



    //MARK: - main Section


    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - Contraints Section


    private func setupView() {
        self.contentView.addSubview(mainView)
        self.mainView.addSubview(topStackView)
        self.topStackView.addArrangedSubview(photosLabel)
        self.topStackView.addArrangedSubview(rightLabel)
        self.mainView.addSubview(downStackView)
        self.downStackView.addArrangedSubview(photo1)
        self.downStackView.addArrangedSubview(photo2)
        self.downStackView.addArrangedSubview(photo3)
        self.downStackView.addArrangedSubview(photo4)


        let mainViewConstraints = self.mainViewConstraints()
        let topStackViewConstraints = self.topStackViewConstraints()

        let downStackViewConstraints = self.downStackViewConstraints()
        let photosLabelConstraints = self.photosLabelConstraints()
        let rightLabelConstraints = self.rightLabelConstraints()

        NSLayoutConstraint.activate(
                                    mainViewConstraints
                                    + topStackViewConstraints
                                    + photosLabelConstraints
                                    + rightLabelConstraints

                                    + downStackViewConstraints

                                    )
    }


    private func mainViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.mainView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let bottomConstraints = self.mainView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        let leadingConstraint = self.mainView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingConstraint = self.mainView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)

        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraints]
    }

    private func topStackViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.topStackView.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 12)
        let bottomConstraints = self.topStackView.heightAnchor.constraint(equalToConstant: 32)
        let leadingConstraint = self.topStackView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 12)
        let trailingConstraint = self.topStackView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -12)

        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraints]
    }

    private func downStackViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.downStackView.topAnchor.constraint(equalTo: self.topStackView.bottomAnchor)
        let bottomConstraints = self.downStackView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -12)
        let leadingConstraint = self.downStackView.leftAnchor.constraint(equalTo: self.mainView.leftAnchor, constant: 12)
        let trailingConstraint = self.downStackView.rightAnchor.constraint(equalTo: self.mainView.rightAnchor, constant: -12)

        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraints]
    }

    private func photosLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.photosLabel.topAnchor.constraint(equalTo: self.topStackView.topAnchor)
        let leadingConstraint = self.photosLabel.leftAnchor.constraint(equalTo: self.topStackView.leftAnchor)
        let trailingConstraint = self.photosLabel.rightAnchor.constraint(equalTo: self.topStackView.centerXAnchor)
        let heightConstraint = self.photosLabel.heightAnchor.constraint(equalToConstant: 20)

        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }

    private func rightLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.rightLabel.centerYAnchor.constraint(equalTo: self.photosLabel.centerYAnchor)
        let trailingConstraint = self.rightLabel.centerXAnchor.constraint(equalTo: self.topStackView.rightAnchor, constant: -20)
        let heightConstraint = self.rightLabel.heightAnchor.constraint(equalToConstant: 20)
        let widthConstraint = self.rightLabel.widthAnchor.constraint(equalToConstant: 20)

        return [topConstraint, trailingConstraint, heightConstraint, widthConstraint]
    }




}
