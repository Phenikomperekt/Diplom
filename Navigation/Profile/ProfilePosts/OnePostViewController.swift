//
//  PostViewController.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 16.04.2022.
//

import UIKit

class OnePostViewController: UIViewController {

    var authorText: String
    var postImageViewString: String
    var descriptionText: String
    var likesCount: Int
    var viewsCount: Int

    private var screenWidth: CGFloat { view.bounds.width }


    init(authorText: String, postImageViewString: String, descriptionText: String, likesCount: Int, viewsCount: Int) {
        self.authorText = authorText
        self.postImageViewString = postImageViewString
        self.descriptionText = descriptionText
        self.likesCount = likesCount
        self.viewsCount = viewsCount
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        let font: UIFont = UIFont.boldSystemFont(ofSize: 20)
        authorLabel.backgroundColor = .clear
        authorLabel.numberOfLines = 2
        authorLabel.font = font
        authorLabel.textColor = .black
        authorLabel.translatesAutoresizingMaskIntoConstraints = false

        return authorLabel
    }()

    private lazy var postImageView: UIImageView = {
        let postImageView = UIImageView()
        let coordinates = UIScreen.main.bounds.width
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.backgroundColor = .black
        postImageView.contentMode = .scaleAspectFit

        return postImageView
    }()

    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        let font: UIFont = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = font
        descriptionLabel.textColor = .systemGray
        descriptionLabel.textAlignment = .justified
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()

    private lazy var bottomStackView: UIStackView = {
        let bottomStackView = UIStackView()
        bottomStackView.backgroundColor = .systemGray6
        bottomStackView.axis = .horizontal
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        return bottomStackView
    }()

    private lazy var likesButton: UIButton = {
        let likesButton = UIButton()
        likesButton.setTitle("  Likes:", for: .normal)
        likesButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        likesButton.setTitleColor(.systemOrange, for: .normal)
        likesButton.setTitleShadowColor(.systemRed, for: .normal)
        likesButton.backgroundColor = .white
        likesButton.setTitleShadowColor(.black, for: .normal)

        return likesButton
    }()

    private lazy var viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        let font: UIFont = UIFont.systemFont(ofSize: 16)
        viewsLabel.font = font
        viewsLabel.textColor = .black
        viewsLabel.textAlignment = .right
        return viewsLabel
    }()

    private func initVariables() {
        authorLabel.text = self.authorText
        postImageView.image = UIImage(named: self.postImageViewString)
        descriptionLabel.text = self.descriptionText
        likesButton.setTitle("  Likes: " + String(self.likesCount), for: .normal)
        viewsLabel.text = "Views: " + String(self.viewsCount)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initVariables()
        setupView()
    }
    
    private func setupView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(backView)
        self.backView.addSubview(authorLabel)
        self.backView.addSubview(postImageView)
        self.backView.addSubview(descriptionLabel)
        self.backView.addSubview(bottomStackView)
        self.bottomStackView.addArrangedSubview(likesButton)
        self.bottomStackView.addArrangedSubview(viewsLabel)

        let backViewConstraints = self.backViewConstraints()
        let scrollViewConstraints = self.scrollViewConstraints()
        let authorLabelConstraints = self.authorLabelConstraints()
        let imageViewConstraints = self.imageViewConstraints()
        let descriptionLabelConstraints = self.descriptionLabelConstraints()
        let bottomStackViewConstrints = self.bottomStackViewConstrints()

        NSLayoutConstraint.activate(
                                      scrollViewConstraints
                                    + backViewConstraints
                                    + authorLabelConstraints
                                    + imageViewConstraints
                                    + descriptionLabelConstraints
                                    + bottomStackViewConstrints
                                    )

    }

    private func scrollViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        let trailingConstraint = self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        let bottomConstraints = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)

        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraints]
    }

    private func backViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.backView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let leadingConstraint = self.backView.leftAnchor.constraint(equalTo: self.scrollView.layoutMarginsGuide.leftAnchor)
        let trailingConstraint = self.backView.rightAnchor.constraint(equalTo: self.scrollView.layoutMarginsGuide.rightAnchor)
        let bottomConstraints = self.backView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)

        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraints]
    }

    private func authorLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = authorLabel.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 16)
        let leadingConstraint = authorLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingConstraint = authorLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        return [topConstraint, leadingConstraint, trailingConstraint]
    }

    private func imageViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = postImageView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 12)
        let leadingConstraint = postImageView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingImageContraint = postImageView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        let widthImageContraint = postImageView.widthAnchor.constraint(equalToConstant: screenWidth)
        let heightImageConstraint = postImageView.heightAnchor.constraint(equalToConstant: screenWidth)

        return [
            topConstraint, leadingConstraint, trailingImageContraint, widthImageContraint, heightImageConstraint
        ]
    }

    private func descriptionLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16)
        let leadingConstraint = descriptionLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingConstraint = descriptionLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)

        return [
            topConstraint, leadingConstraint, trailingConstraint
        ]
    }

    private func bottomStackViewConstrints() -> [NSLayoutConstraint] {
        let topConstraint = bottomStackView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16)
        let leadingConstraint = bottomStackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingConstraint = bottomStackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        let bottomConstraints = bottomStackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor)
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraints]
    }

    private func viewsLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = viewsLabel.topAnchor.constraint(equalTo: self.bottomStackView.bottomAnchor)
        let leadingConstrint = viewsLabel.leadingAnchor.constraint(equalTo: self.bottomStackView.centerXAnchor)
        let trailingConstraint = viewsLabel.rightAnchor.constraint(equalTo: self.bottomStackView.rightAnchor)
        return [topConstraint, leadingConstrint, trailingConstraint]
    }

}

