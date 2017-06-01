//
//  UIApplicationExtensions.swift
//  Pods
//
//  Created by frank on 2017. 5. 31..
//
//

import UIKit

public extension UIApplication {

    public class func topVC() -> UIViewController? {
        guard let rootVC = UIApplication.shared.delegate?.window??.rootViewController else { return nil }

        var topViewController = rootVC
        while (topViewController.presentedViewController != nil) {
            topViewController = topViewController.presentedViewController!
        }
        return topViewController
    }
}
