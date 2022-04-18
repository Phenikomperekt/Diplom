//
//  AnimationViewController.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 13.04.2022.
//

import UIKit

final class AnimationViewController: UIViewController {

    var screenWidth: CGFloat { view.bounds.width }
    var initialSize: CGFloat { screenWidth/2 }

    private lazy var avatarView: UIView = {
        let avatarView = UIView()
        avatarView.backgroundColor = .systemRed
        avatarView.isUserInteractionEnabled = true
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.layer.borderWidth = 3.0
        avatarView.layer.borderColor = UIColor.systemGray.cgColor
        avatarView.layer.cornerRadius = initialSize/2
        avatarView.clipsToBounds = true
        return avatarView
    }()

    private lazy var hiddenView: UIView = {
        let hiddenView = UIView()
        hiddenView.backgroundColor = .systemGray6
        hiddenView.alpha = 0
        hiddenView.isHidden = true
        hiddenView.translatesAutoresizingMaskIntoConstraints = false
        return hiddenView
    }()

    private lazy var avatarImage: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.image = UIImage(named: "39")
        avatarImage.clipsToBounds = false
        return avatarImage
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

    private let tapGestureRecognizer = UITapGestureRecognizer()
    private var isExpanded = false

    private var centerXConstraint: NSLayoutConstraint?
    private var centerXInitialConstraint: NSLayoutConstraint?
    private var centerXZoomConstraint: NSLayoutConstraint?
    private var centerYConstraint: NSLayoutConstraint?
    private var centerYInitialConstraint: NSLayoutConstraint?
    private var centerYZoomConstraint: NSLayoutConstraint?

    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "texture")!)
        self.view.addSubview(hiddenView)
        self.view.addSubview(avatarView)
        self.avatarView.addSubview(avatarImage)
        self.view.addSubview(closeButton)
        self.setupView()
        self.setupGesture()
    }
    
    private func setupView() {
        let topHidden = self.hiddenView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let bottomHidden = self.hiddenView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let leadingHidden = self.hiddenView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingHidden = self.hiddenView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)

        self.centerXConstraint = self.avatarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -50)
        self.centerXInitialConstraint = self.avatarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -50)
        self.centerXZoomConstraint = self.avatarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)


        self.centerYConstraint = self.avatarView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -initialSize)
        self.centerYInitialConstraint = self.avatarView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -initialSize)
        self.centerYZoomConstraint = self.avatarView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)


        self.widthConstraint = self.avatarView.widthAnchor.constraint(equalToConstant: initialSize)
        self.heightConstraint = self.avatarView.heightAnchor.constraint(equalToConstant: initialSize)

        let topImage = self.avatarImage.topAnchor.constraint(equalTo: self.avatarView.topAnchor)
        let bottomImage = self.avatarImage.bottomAnchor.constraint(equalTo: self.avatarView.bottomAnchor)
        let leadingImage = self.avatarImage.leadingAnchor.constraint(equalTo: self.avatarView.leadingAnchor)
        let trailingImage = self.avatarImage.trailingAnchor.constraint(equalTo: self.avatarView.trailingAnchor)

        let topCloseButton = self.closeButton.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 10)
        let ledingCloseButton = self.closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5)
        let heightCloseButton = closeButton.heightAnchor.constraint(equalToConstant: 50)
        let widthCloseButton = closeButton.widthAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([
                                     topHidden, bottomHidden, leadingHidden, trailingHidden,
                                     self.centerXConstraint, self.centerYConstraint, widthConstraint, heightConstraint,
                                     topImage, bottomImage, leadingImage, trailingImage,
                                     topCloseButton, ledingCloseButton, heightCloseButton, widthCloseButton
                                    ].compactMap({ $0 }))
    }

    private func setupGesture() {
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.handleTapGesture(_:)))
        self.avatarView.addGestureRecognizer(self.tapGestureRecognizer)
    }

    private func animateCloseButton(_ whereIs: Bool) {
        if whereIs {
            UIView.animate(withDuration: 0.3) { [self] in
                self.closeButton.alpha = self.isExpanded ? 1 : 0
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.closeButton.isHidden = !self.isExpanded
            }
        } else { return }
    }

    private func animationMagic(_ interactionEnable: Bool) {
        self.isExpanded.toggle()

        self.widthConstraint?.constant = self.isExpanded ? screenWidth : initialSize
        self.heightConstraint?.constant = self.isExpanded ? screenWidth : initialSize
        self.centerXConstraint?.constant = self.isExpanded ? self.centerXZoomConstraint!.constant : self.centerXInitialConstraint!.constant
        self.centerYConstraint?.constant = self.isExpanded ? self.centerYZoomConstraint!.constant : self.centerYInitialConstraint!.constant
        self.animateCloseButton(interactionEnable)

        if self.isExpanded {
            self.hiddenView.isHidden = false
            self.closeButton.isHidden = false
        }

        UIView.animate(withDuration: 0.5) { [self] in
            self.hiddenView.alpha = self.isExpanded ? 1 : 0

//            self.closeButton.alpha = self.isExpanded ? 1 : 0
            self.avatarView.layer.cornerRadius = self.isExpanded ? 0 : self.initialSize/2

            self.view.layoutIfNeeded()
        } completion: { _ in
            self.hiddenView.isHidden = !self.isExpanded

//            self.closeButton.isHidden = !self.isExpanded
            self.avatarView.isUserInteractionEnabled = interactionEnable
            self.animateCloseButton(!interactionEnable)
        }
    }

    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapGestureRecognizer === gestureRecognizer else { return }
        animationMagic(false)

    }

    @objc private func didTapButton() {
        animationMagic(true)
    }
}
