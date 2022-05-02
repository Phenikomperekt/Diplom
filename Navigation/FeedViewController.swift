//
//  FeedViewController.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 02.03.2022.
//

import UIKit

class FeedViewController: UIViewController {


        private lazy var feedStackView: UIStackView = {
            let feedStackView = UIStackView()
//            feedStackView.attributesStackView()
            feedStackView.axis = .vertical
            feedStackView.spacing = 10.0
            feedStackView.alignment = .fill
            feedStackView.distribution = .fillEqually
            feedStackView.translatesAutoresizingMaskIntoConstraints = false
            feedStackView.insertArrangedSubview(postButton, at: 0)
            feedStackView.insertArrangedSubview(postButton2, at: 1)

            return feedStackView
        }()


        override func viewDidLoad() {
            navigationController?.setNavigationBarHidden(true, animated: false)
            self.tabBarController?.tabBar.isHidden = false
            
            super.viewDidLoad()
            self.view.backgroundColor = .systemGray5
            self.navigationItem.title = "Post list"

            self.view.addSubview(feedStackView)

            let bottonStackView = self.feedStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            let leadingStackView = self.feedStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
            let trailingStackView = self.feedStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
            let heightStackView = self.feedStackView.heightAnchor.constraint(equalToConstant: 120)
            NSLayoutConstraint.activate([bottonStackView, leadingStackView, trailingStackView, heightStackView])

        }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = false

    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: false)
//        self.tabBarController?.tabBar.isHidden = true
//    }

        private lazy var postButton: UIButton = {
          let postButton = UIButton()
          postButton.setTitle("to Post-1", for: .normal)
          postButton.setTitleColor(.white, for: .normal)
          postButton.setTitleColor(.systemGray, for: .selected)
          postButton.setTitleShadowColor(.systemMint, for: .normal)
          postButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
          postButton.backgroundColor = .systemBlue
          postButton.layer.cornerRadius = 12.0
          postButton.translatesAutoresizingMaskIntoConstraints = false

          return postButton
      }()

    

    private lazy var postButton2: UIButton = {
          let postButton = UIButton()
          postButton.setTitle("to Post-2", for: .normal)
          postButton.setTitleColor(.white, for: .normal)
          postButton.setTitleColor(.systemGray, for: .selected)
          postButton.setTitleShadowColor(.systemMint, for: .normal)
          postButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
          postButton.backgroundColor = .systemRed
          postButton.layer.cornerRadius = 12.0
          postButton.translatesAutoresizingMaskIntoConstraints = false

          return postButton
      }()

        @objc private func didTapButton () {
            let vc = PostViewController()

            PostViewController.post.title = "Title of Post"


            self.navigationController?.pushViewController(vc, animated: true)

        }



}
