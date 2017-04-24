//
//  TabbarVCGenerator.swift
//  Pods
//
//  Created by frank on 2017. 4. 24..
//
//

import UIKit

enum TabbarVCGenerator {

    struct TabMenuSpec {
        var title: String = "Menu"
        var normalIcon: UIImage
        var selectedIcon: UIImage
        var viewController: UIViewController
        var imbeddedInNavigationController: Bool = true
    }

    static func tabVC(menuSpecs: [TabMenuSpec]) -> UITabBarController {

        let tabVC = UITabBarController()
        tabVC.viewControllers = menuSpecs.map { (spec) -> UIViewController in
            let vc = spec.imbeddedInNavigationController ? UINavigationController(rootViewController: spec.viewController) : spec.viewController
            vc.tabBarItem = UITabBarItem(title: spec.title, image: spec.normalIcon, selectedImage: spec.selectedIcon)
            return vc
        }
        return tabVC
    }
}
