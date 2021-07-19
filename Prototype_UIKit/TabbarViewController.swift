//
//  ViewController.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 07.07.21.
//

import UIKit

final class TabbarViewController: UITabBarController {
    
    private lazy var mockOne: UIViewController = {
        let tabItem = UITabBarItem(title: "Mock1", image: nil, selectedImage: nil)
        let viewController = MockScreenOneViewController()
        viewController.tabBarItem = tabItem
        return viewController
    }()
    
    private lazy var mockTwo: UIViewController = {
        let tabItem = UITabBarItem(title: "Mock2", image: nil, selectedImage: nil)
        let viewController = MockScreenTwoViewController()
        viewController.tabBarItem = tabItem
        return viewController
    }()
    
    private lazy var mockThree: UIViewController = {
        let tabItem = UITabBarItem(title: "Mock3", image: nil, selectedImage: nil)
        let viewController = MockScreenThreeViewController()
        viewController.tabBarItem = tabItem
        return viewController
    }()
    
    private lazy var mockFour: UIViewController = {
        let tabItem = UITabBarItem(title: "Mock4", image: nil, selectedImage: nil)
        let viewController = MockScreenFourViewController()
        viewController.tabBarItem = tabItem
        return UINavigationController(rootViewController: viewController)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [mockOne, mockTwo, mockThree, mockFour]
    }
}
