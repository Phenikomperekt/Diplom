//
//  ZoomViewController.swift
//  HUI6
//
//  Created by Evgeny Mastepan on 07.04.2022.
//

import UIKit

class ZoomViewController: UIViewController {

    private lazy var photoItem: UIImageView = {
        let photoItem = UIImageView()
        photoItem.contentMode = .scaleAspectFit
        photoItem.backgroundColor = .black
        photoItem.translatesAutoresizingMaskIntoConstraints = false
        return photoItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black


        self.view.addSubview(photoItem)
        

        let top = self.photoItem.topAnchor.constraint(equalTo: self.view.topAnchor)
        let down = self.photoItem.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let left = self.photoItem.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        let right = self.photoItem.rightAnchor.constraint(equalTo: self.view.rightAnchor)


        NSLayoutConstraint.activate([
                                    top, down, left, right
                                    ])

    }

    func setup(with currentImage: UIImage) {
        self.photoItem.image = currentImage
    }

}
