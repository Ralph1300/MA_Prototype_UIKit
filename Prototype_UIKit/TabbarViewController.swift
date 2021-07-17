//
//  ViewController.swift
//  Prototype_UIKit
//
//  Created by Ralph Schnalzenberger on 07.07.21.
//

import UIKit

final class TabbarViewController: UITabBarController {
    
    private lazy var mockOne: MockScreenOneViewController = {
        let tabItem = UITabBarItem(title: "Mock1", image: nil, selectedImage: nil)
        let viewController = MockScreenOneViewController()
        viewController.tabBarItem = tabItem
        return viewController
    }()
    
    private lazy var mockTwo: MockScreenTwoViewController = {
        let tabItem = UITabBarItem(title: "Mock2", image: nil, selectedImage: nil)
        let viewController = MockScreenTwoViewController()
        viewController.tabBarItem = tabItem
        return viewController
    }()
    
    private lazy var mockThree: MockScreenThreeViewController = {
        let tabItem = UITabBarItem(title: "Mock3", image: nil, selectedImage: nil)
        let viewController = MockScreenThreeViewController()
        viewController.tabBarItem = tabItem
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [mockOne, mockTwo, mockThree]
    }
}
