//
//  PhotosViewController.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 07.04.2022.
//

import UIKit

class PhotosViewController: UIViewController {

    var post = Post(title: "Text1", text: "Text2")
    var images = [UIImage]()
    let photosInRow: CGFloat = 3
    var screenWidth: CGFloat { view.bounds.width }
    var initialSize: CGFloat { screenWidth/2 }
    var initaialYSize: CGFloat { view.bounds.height }

    private var isExpanded = false
    private var itemStartWidthSize: CGFloat = 0

    private var centerXConstraint: NSLayoutConstraint?
    private var centerXInitialConstraint: NSLayoutConstraint?
    private var centerXZoomConstraint: NSLayoutConstraint?
    
    private var centerYConstraint: NSLayoutConstraint?
    private var centerYInitialConstraint: NSLayoutConstraint?
    private var centerYZoomConstraint: NSLayoutConstraint?

    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?

    private func addImage() {
        for i in 1...45 {
            let image = UIImage(named: "\(i)")!
            images.append(image)
        }
    }

    private lazy var hiddenView: UIView = {
        let hiddenView = UIView()
        hiddenView.backgroundColor = .black
        hiddenView.alpha = 0
        hiddenView.isHidden = true
        hiddenView.translatesAutoresizingMaskIntoConstraints = false
        return hiddenView
    }()

    private lazy var photoItem: UIImageView = {
        let photoItem = UIImageView()
        photoItem.translatesAutoresizingMaskIntoConstraints = false
        photoItem.isHidden = true
        return photoItem
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        let largeIcon = UIImage.SymbolConfiguration(pointSize: 140)
        let iconImage = UIImage(systemName: "multiply.circle.fill", withConfiguration: largeIcon)?.withTintColor(.red, renderingMode: .alwaysOriginal)
        closeButton.setImage(iconImage, for: .normal)
        closeButton.backgroundColor = .systemGray6
        closeButton.isHidden = true
        closeButton.alpha = 0
        closeButton.clipsToBounds = true
        closeButton.layer.cornerRadius = 25
        closeButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return closeButton
    }()

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8.0
        layout.minimumLineSpacing = 8.0
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.leftBarButtonItem?.isEnabled = true


        self.addImage()
        self.view.backgroundColor = .white
        self.navigationItem.title = post.title
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.hiddenView)
        self.view.addSubview(self.photoItem)
        self.view.addSubview(self.closeButton)

        let topConstraint = self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leftConstraint = self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8)
        let rightConstraint = self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8)
        let bottomConstraint = self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)

        let topHidden = self.hiddenView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leftHidden = self.hiddenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let rightHidden = self.hiddenView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomHidden = self.hiddenView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)

        let topCloseButton = self.closeButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor)
        let downCloseButton = self.closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5)
        let leftCloseButton = self.closeButton.heightAnchor.constraint(equalToConstant: 50)
        let rightCloseButton = self.closeButton.widthAnchor.constraint(equalToConstant: 50)

        self.centerXConstraint = self.photoItem.topAnchor.constraint(equalTo: self.view.topAnchor)
        self.centerYConstraint = self.photoItem.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)

        self.centerXInitialConstraint = self.photoItem.topAnchor.constraint(equalTo: self.view.topAnchor)
        self.centerYInitialConstraint = self.photoItem.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)

        self.centerXZoomConstraint = self.photoItem.topAnchor.constraint(equalTo: self.view.topAnchor, constant: initialSize)
        self.centerYZoomConstraint = self.photoItem.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)

        self.widthConstraint = self.photoItem.widthAnchor.constraint(equalToConstant: itemStartWidthSize)
        self.heightConstraint = self.photoItem.heightAnchor.constraint(equalToConstant: itemStartWidthSize)

        NSLayoutConstraint.activate([
                                    topConstraint, leftConstraint, rightConstraint, bottomConstraint,
                                    topHidden, leftHidden, rightHidden, bottomHidden,
                                    self.centerXConstraint, self.centerYConstraint, widthConstraint, heightConstraint,
                                    topCloseButton, downCloseButton, leftCloseButton, rightCloseButton
                                    ].compactMap({ $0 }))

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: false)

    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = true
//        navigationController?.setNavigationBarHidden(true, animated: false)
//    }

    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 2 * spacing
        let itemWidth = floor(neededWidth / photosInRow)
        itemStartWidthSize = itemWidth

        return CGSize(width: itemWidth, height: itemWidth)
    }

    private func convertCoordinats(tapCoordinates: CGPoint) {
        print ("0.0: ", centerYConstraint!.constant, centerXConstraint!.constant, isExpanded)
        print ("0.1: ", centerYInitialConstraint!.constant, centerXInitialConstraint!.constant, isExpanded)
        print ("0.2: ", centerYZoomConstraint!.constant, centerXZoomConstraint!.constant, isExpanded)
        photoItem.isHidden = false
        self.centerXInitialConstraint = self.photoItem.topAnchor.constraint(equalTo: self.view.topAnchor, constant: tapCoordinates.y)
        self.centerYInitialConstraint = self.photoItem.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: tapCoordinates.x)
        print ("0.1.0: ", centerYConstraint!.constant, centerXConstraint!.constant, isExpanded)
        print ("0.1.1: ", centerYInitialConstraint!.constant, centerXInitialConstraint!.constant, isExpanded)
        print ("0.1.2: ", centerYZoomConstraint!.constant, centerXZoomConstraint!.constant, isExpanded)
            self.centerXConstraint?.constant = self.centerXInitialConstraint!.constant
            self.centerYConstraint?.constant = self.centerYInitialConstraint!.constant
            self.widthConstraint?.constant = itemStartWidthSize
            self.heightConstraint?.constant = itemStartWidthSize

        print ("0.2.0: ", centerYConstraint!.constant, centerXConstraint!.constant, isExpanded)
        print ("0.2.1: ", centerYInitialConstraint!.constant, centerXInitialConstraint!.constant, isExpanded)
        print ("0.2.2: ", centerYZoomConstraint!.constant, centerXZoomConstraint!.constant, isExpanded)


    }


    private func animationMagic(with currentImage: UIImage) {
        print ("1.0: ", centerYConstraint!.constant, centerXConstraint!.constant, isExpanded)
        print ("1.1: ", centerYInitialConstraint!.constant, centerXInitialConstraint!.constant, isExpanded)
        print ("1.2: ", centerYZoomConstraint!.constant, centerXZoomConstraint!.constant, isExpanded)

        if self.isExpanded {
            print ("2.0: ", centerYConstraint!.constant, centerXConstraint!.constant, isExpanded)
            print ("2.1: ", centerYInitialConstraint!.constant, centerXInitialConstraint!.constant, isExpanded)
            print ("2.2: ", centerYZoomConstraint!.constant, centerXZoomConstraint!.constant, isExpanded)
            self.widthConstraint?.constant = screenWidth
            self.heightConstraint?.constant = screenWidth
            self.hiddenView.isHidden = false
            self.closeButton.isHidden = false
            self.centerXConstraint?.constant = self.centerXZoomConstraint!.constant
            self.centerYConstraint?.constant = self.centerYZoomConstraint!.constant
            print ("3.0: ", centerYConstraint!.constant, centerXConstraint!.constant, isExpanded)
            print ("3.1: ", centerYInitialConstraint!.constant, centerXInitialConstraint!.constant, isExpanded)
            print ("3.2: ", centerYZoomConstraint!.constant, centerXZoomConstraint!.constant, isExpanded)
        }

        if !self.isExpanded {
            print ("4.0: ", centerYConstraint!.constant, centerXConstraint!.constant, isExpanded)
            print ("4.1: ", centerYInitialConstraint!.constant, centerXInitialConstraint!.constant, isExpanded)
            print ("4.2: ", centerYZoomConstraint!.constant, centerXZoomConstraint!.constant, isExpanded)
            self.centerXConstraint?.constant = self.centerXInitialConstraint!.constant
            self.centerYConstraint?.constant = self.centerYInitialConstraint!.constant
            self.widthConstraint?.constant = itemStartWidthSize
            self.heightConstraint?.constant = itemStartWidthSize
            print ("5.0: ", centerYConstraint!.constant, centerXConstraint!.constant, isExpanded)
            print ("5.1: ", centerYInitialConstraint!.constant, centerXInitialConstraint!.constant, isExpanded)
            print ("5.2: ", centerYZoomConstraint!.constant, centerXZoomConstraint!.constant, isExpanded)
        }

        UIView.animate(withDuration: 1) { [self] in
            self.hiddenView.alpha = self.isExpanded ? 1 : 0
            self.closeButton.alpha = self.isExpanded ? 1 : 0

            self.view.layoutIfNeeded()
        } completion: { _ in
            self.hiddenView.isHidden = !self.isExpanded
            self.photoItem.isHidden = !self.isExpanded
            self.closeButton.isHidden = !self.isExpanded

        }

    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            cell.backgroundColor = .systemRed
            return cell
        }

        let image = images[indexPath.item]

        cell.setup(with: image)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing

        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let currentImage: UIImage = UIImage(named: "\(indexPath.item + 1)")!

        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionViewCell
        let tap = CGPoint(x: 0, y: 0)
        let convertTap = cell.convert(tap, to: self.view)
        self.isExpanded = true
        photoItem.image = currentImage
        convertCoordinats(tapCoordinates: convertTap)
        animationMagic(with: currentImage)
    }

    @objc private func didTapButton() {
        guard let image = photoItem.image else { return }
        self.isExpanded = false
        animationMagic(with: image)
    }

}
