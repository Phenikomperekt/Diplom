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
        case animation

        var title: String {
            switch self {
            case .feed:
                return "Feed"
            case .profile:
                return "Profile"
            case .animation:
                return "Animation"

            }
        }

        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "newspaper")
            case .profile:
                return UIImage(systemName: "person.crop.square")
            case .animation:
                return UIImage(systemName: "sparkles")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
        self.tabBar.backgroundColor = .systemGray6

        

    }

    func setupTabBar() {
        let items: [TabBarItem] = [.feed, .profile, .animation]
        self.viewControllers = items.map({ tabBarItem in
            switch tabBarItem {
            case .feed:
                return UINavigationController(rootViewController: FeedViewController())
            case .profile:
                return UINavigationController(rootViewController: LogInViewController())
            case .animation:
                return UINavigationController(rootViewController: AnimationViewController())
            }
        })

        self.viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = items[index].title
            vc.tabBarItem.image = items[index].image
        })
    }

}

