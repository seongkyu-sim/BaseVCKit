//
//  TabbarVCGenerator.swift
//  Pods
//
//  Created by frank on 2017. 4. 24..
//
//

import UIKit

public enum TabbarVCGenerator {

    public struct TabMenuSpec {
        public var viewController: UIViewController
        // imbedded
        public var imbeddedInNavigationController: Bool
        // custom item
        public var title: String?
        public var normalIcon: UIImage?
        public var selectedIcon: UIImage?
        // system default item
        public var systemItem: UITabBarSystemItem?

        public init(viewController: UIViewController, systemItem: UITabBarSystemItem, imbeddedInNavigationController: Bool = true) {
            self.viewController = viewController
            self.systemItem = systemItem
            self.imbeddedInNavigationController = imbeddedInNavigationController
        }

        public init(viewController: UIViewController, title: String, normalIcon: UIImage, selectedIcon: UIImage? = nil, imbeddedInNavigationController: Bool = true) {
            self.viewController = viewController
            self.title = title
            self.normalIcon = normalIcon
            self.selectedIcon = selectedIcon
            self.imbeddedInNavigationController = imbeddedInNavigationController
        }

    }

    public static func tabVC(menuSpecs: [TabMenuSpec]) -> UITabBarController {

        let tabVC = UITabBarController()
        tabVC.viewControllers = menuSpecs.map { (spec) -> UIViewController in
            let vc = spec.imbeddedInNavigationController ? UINavigationController(rootViewController: spec.viewController) : spec.viewController
            if let systemItem = spec.systemItem {
                vc.tabBarItem = UITabBarItem(tabBarSystemItem: systemItem, tag: 0)
            }else {
                vc.tabBarItem = UITabBarItem(title: spec.title, image: spec.normalIcon, selectedImage: spec.selectedIcon)
            }
            return vc
        }
        return tabVC
    }
}
