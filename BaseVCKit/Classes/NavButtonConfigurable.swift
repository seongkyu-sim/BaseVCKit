//
//  NavButtonConfigurable.swift
//  Pods
//
//  Created by frank on 2017. 4. 19..
//
//

import UIKit

/**
 * This protoco is for UIViewController
 */

// MARK: - VCPresentType

public enum VCPresentStatus: String {
    case unknown = "unknown", root = "root", drilled = "drilled", modal = "modal"

    init(presentTypedVC: VCPresentType) {
        if presentTypedVC.isPresentedMyModal {
            self = .modal
        }else if presentTypedVC.isPrsentedByPush {
            self = .drilled
        }else {
            self = .root
        }
    }
}

public protocol VCPresentType: class {
    var presentStatus: VCPresentStatus { get }
    var isPresentedMyModal: Bool { get }
    var isPrsentedByPush: Bool { get }
}

extension VCPresentType where Self: UIViewController {
    public var presentStatus: VCPresentStatus {
        return VCPresentStatus(presentTypedVC: self)
    }

    public var isPresentedMyModal: Bool {

        let keyWindow = UIApplication.shared.keyWindow

        guard let _ = keyWindow?.rootViewController else {
            /**
             * 1. very first time at launch app
             * 2. self(ViewController) is not wrapped with UITabbarController or UINavigationController
             */
            return false
        }

        if keyWindow?.rootViewController == self {
            return false
        }

        if let navigationController = self.navigationController, navigationController.viewControllers.first != self {
            return false
        }
        if self.presentingViewController != nil {
            return true
        }
        if self.presentingViewController?.presentedViewController == self {
            return true
        }
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        }
        if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }

    public var isPrsentedByPush: Bool {
        if let navController = self.navigationController, navController.viewControllers.count > 1 {
            return true
        }
        return false
    }
}


// MARK: - NavigationButtonConfigurable

public protocol NavButtonConfigurable: class, VCPresentType {
    var backButtonIcon: UIImage? { get }
    var backButtonTitle: String? { get }
    var closeButtonIcon: UIImage? { get }

    func configureBackOrCloseOnNavBar() // should called when 'ViewDidLoad'
    func configureNavBarItem(btn: UIButton, isLeft: Bool) // todo: Should update for muptiple button
    func hideBackButton()
    func hideBackButton(animated: Bool)
}

extension NavButtonConfigurable where Self: UIViewController {
    public var backButtonIcon: UIImage? {
        return nil
    }
    public var backButtonTitle: String? {
        return nil
    }
    public var closeButtonIcon: UIImage? {
        return nil
    }

    public func configureBackOrCloseOnNavBar() {
        switch presentStatus {
        case .drilled: // set back button
            configureBackButton(icon: backButtonIcon, title: backButtonTitle)
        case .modal:
            configureCloseButton(icon: closeButtonIcon)
        default: break
        }
    }

    public func configureNavBarItem(btn: UIButton, isLeft: Bool) {
        let barButton = UIBarButtonItem(customView: btn)
        if isLeft {
            navigationItem.leftBarButtonItem = barButton
        }else {
            navigationItem.rightBarButtonItem = barButton
        }
    }

    public func hideBackButton() {
        hideBackButton(animated: false)
    }

    public func hideBackButton(animated: Bool = false) {
        navigationItem.setHidesBackButton(true, animated: animated)
    }
}



// MARK: - Extension of UIViewController

extension UIViewController {

    public func configureBackButton(icon: UIImage?, title: String?) {

        if let icon = icon {
            self.navigationController?.navigationBar.backIndicatorImage = icon
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = icon
        }

        if let title = title {
            if let nav = self.navigationController,
                let item = nav.navigationBar.topItem {
                item.backBarButtonItem  = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.dismissAction))
            } else {
                if let nav = self.navigationController,
                    let _ = nav.navigationBar.backItem {
                    self.navigationController!.navigationBar.backItem!.title = title
                }
            }
        }
    }

    public func configureCloseButton(icon: UIImage?) {
        var barButton: UIBarButtonItem!
        if let icon = icon {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: 0, y: 0, width: 21, height: 21)
            btn.setImage(icon, for: .normal)
            btn.addTarget(self, action: #selector(self.dismissAction), for: .touchUpInside)
            barButton = UIBarButtonItem(customView: btn)
        }else {
            barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(self.dismissAction))
        }
        navigationItem.leftBarButtonItem = barButton
    }

    func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

