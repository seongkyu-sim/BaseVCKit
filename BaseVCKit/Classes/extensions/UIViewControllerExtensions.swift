//
//  UIViewControllerExtensions.swift
//  BaseVCKit
//
//  Created by frank on 2015. 11. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

public extension UIViewController {

    // MARK: - Dismiss keyboard with touch up background

    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }


    // MARK: -

    func isVisible() -> Bool {
        return isViewLoaded && (view.window != nil)
    }
}



