//
//  TabBarController.swift
//  DIplom
//
//  Created by Evgeny Mastepan on 03.03.2022.
//

import UIKit



class TabBarController: UITabBarController {

    private enum TabBarItem {
        case feed
        case profile

        var title: String {
            switch self {
            case .feed:
                return "Feed"
            case .profile:
                return "Profile"


            }
        }

        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "newspaper")
            case .profile:
                return UIImage(systemName: "person.crop.square")

            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
        self.tabBar.backgroundColor = .systemGray6

        

    }

    func setupTabBar() {
        let items: [TabBarItem] = [.feed, .profile]
        self.viewControllers = items.map({ tabBarItem in
            switch tabBarItem {
            case .feed:
                return UINavigationController(rootViewController: FeedViewController())
            case .profile:
                return UINavigationController(rootViewController: LogInViewController())

            }
        })

        self.viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = items[index].title
            vc.tabBarItem.image = items[index].image
        })
    }

}

