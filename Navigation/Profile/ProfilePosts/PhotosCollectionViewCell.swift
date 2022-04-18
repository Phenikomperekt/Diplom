//
//  PhotosCollectionViewCell.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 07.04.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    private lazy var photoItem: UIImageView = {
        let photoItem = UIImageView()
        photoItem.contentMode = .scaleAspectFit
        photoItem.backgroundColor = .black
        photoItem.translatesAutoresizingMaskIntoConstraints = false
        return photoItem
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.photoItem)

        let top = self.photoItem.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let down = self.photoItem.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        let left = self.photoItem.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)
        let right = self.photoItem.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)


        NSLayoutConstraint.activate([
                                    top, down, left, right
                                    ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoItem.image = nil
    }

    func setup(with currentImage: UIImage) {
        self.photoItem.image = currentImage
    }


}
