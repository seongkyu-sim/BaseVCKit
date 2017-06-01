//
//  BaseViewController.swift
//  BaseVCKit
//
//  Created by frank on 2017. 4. 24..
//  Copyright © 2017년 CocoaPods. All rights reserved.
//

import UIKit
import BaseVCKit

class BaseViewController: UIViewController, EasyNavigatable {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureBackOrCloseOnNavBar()
    }
}


// NavButtonConfigurable
extension BaseViewController: NavButtonConfigurable {
    /*
    final public var backButtonIcon: UIImage? {
        let icon = ImageAssets.arrowLeftIcon
            .imageWithColor(color: UIColor.navIconGray, height: UISize.navIconHeight)
            .imageWithSpaceInsets(insets: UIEdgeInsetsMake(2, 8, 1, 0)) // height should be 21
        return icon
    }
    final public var backButtonTitle: String? {
        return ""
    }
    final public var closeButtonIcon: UIImage? {
        let icon = ImageAssets.xIcon.imageWithColor(color: UIColor.navIconGray, height: UISize.navIconHeight)
        return icon
    }
    */

    var backButtonIcon: UIImage? {
        let icon = ImageAssets.arrowLeftIcon
        return icon
    }

    var backButtonTitle: String? { return "" }
}


