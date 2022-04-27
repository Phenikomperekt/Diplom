//
//  PostViewController.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 03.03.2022.
//

import UIKit

class PostViewController: UIViewController {
    static var post = Post(title: "Text1", text: "Text2")


    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray4
        self.navigationItem.title = PostViewController.post.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoButton))


    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false

    }

    @objc private func infoButton () {
        let vc = InfoViewController()
        
        navigationController?.present(vc, animated: true, completion: nil)

        
    }
}
