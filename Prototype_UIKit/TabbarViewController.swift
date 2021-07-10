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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [mockOne]
    }
}
