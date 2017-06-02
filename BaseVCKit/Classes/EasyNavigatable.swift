//
//  EasyNavigatable.swift
//  BaseVCKit
//
//  Created by frank on 2017. 4. 19..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

/**
 * This protoco is for UIViewController
 */

public protocol EasyNavigatable: class {
    func push(_ viewController: UIViewController)
    func push(_ viewController: UIViewController, isHideBottomBar: Bool)
    func push(_ viewController: UIViewController, isHideBottomBar: Bool, animated: Bool)
    func modal(_ viewController: UIViewController)
    func modal(_ viewController: UIViewController, animated: Bool)
    func back()
    func back(animated: Bool)
}

extension EasyNavigatable where Self: UIViewController {

    public func push(_ viewController: UIViewController) {
        push(viewController, isHideBottomBar: false, animated: true)
    }

    public func push(_ viewController: UIViewController, isHideBottomBar: Bool) {
        push(viewController, isHideBottomBar: isHideBottomBar, animated: true)
    }

    public func push(_ viewController: UIViewController, isHideBottomBar: Bool, animated: Bool) {
        if let nv = navigationController {
            if isHideBottomBar { hidesBottomBarWhenPushed = true }
            nv.pushViewController(viewController, animated: animated)
            if isHideBottomBar { hidesBottomBarWhenPushed = false }
        }
    }

    public func modal(_ viewController: UIViewController) {
        modal(viewController, animated: true)
    }

    public func modal(_ viewController: UIViewController, animated: Bool = true) {
        let nav = UINavigationController(rootViewController: viewController)
        if let tc = tabBarController {
            tc.present(nav, animated: animated, completion: nil)
        }else if let nv = navigationController {
            nv.present(nav, animated: animated, completion: nil)
        }else {
            present(nav, animated: animated, completion: nil)
        }
    }

    public func back() {
        back(animated: true)
    }

    public func back(animated: Bool) {
        let _ = navigationController?.popViewController(animated: animated)
    }
}

