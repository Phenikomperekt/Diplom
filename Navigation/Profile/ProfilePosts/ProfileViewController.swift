//
//  ViewController.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 01.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileView: ProfileHeaderView = {
        let profileView = ProfileHeaderView()
        return profileView
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTable")
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()

    private var dataSource: [News.Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()

        self.fetchArticles { [weak self] articles in
            self?.dataSource = articles
            self?.tableView.reloadData()
        }
    }

    private func setupView() {
        
        self.view.addSubview(self.tableView)
        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint  = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)

        NSLayoutConstraint.activate([
                                topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
                                    ])
    }

    private func deleteCellBySwipe() {
        print ("Swipe Left")
    }

//MARK: - Date receeved.
    private func fetchArticles(completion: @escaping([News.Article]) -> Void) {
        if let path = Bundle.main.path(forResource: "news", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let news = try
                self.jsonDecoder.decode(News.self, from: data)
                completion(news.articles)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            fatalError("Invalid filename/path.")
        }
    }
}


//MARK: - DataSource & Delegate

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView:UITableView, viewForHeaderInSection section: Int) -> UIView? {
        profileView.addSubViews()
    return profileView
    }

    func tableView(_ tableView:UITableView, heightForHeaderInSection: Int) -> CGFloat {
        let profileViewHeight = profileView.bounds.height
        print("ProfileHeight = ", profileViewHeight)
        return 250
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTable", for: indexPath) as? PhotosTableViewCell else {
                            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                            return cell
                        }

                return cell
            }
        }

        if indexPath.row >= 1 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? PostTableViewCell
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        let article = self.dataSource[indexPath.row - 1]
        let viewModel = PostTableViewCell.ViewModel(author: article.author,
                                                         description: article.description,
                                                         image: article.image,
                                                         likes: article.likes,
                                                         views: article.views)
        cell.setup(with: viewModel)
        return cell
        }
        
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        return defaultCell
    }

    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        let vc = PhotosViewController()
            vc.post.title = "Photo Gallery"
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
////            object.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .none {
//
//        }
//    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let title = NSLocalizedString("Delete", comment: "Delete")

        let action = UIContextualAction(style: .destructive, title: title, handler: {
             (action, view, completionHadler) in
            self.deleteCellBySwipe()
            completionHadler(true)
        })

        action.image = UIImage(systemName: "delete.backward.fill")
        action.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [action])
        
        return configuration
    }


}

