//
//  UIViewControllerExtensions.swift
//  FrankUIKit
//
//  Created by frank on 2015. 11. 10..
//  Copyright © 2015년 treetopworks. All rights reserved.
//

import UIKit

extension UIViewController {

    // MARK: - Dismiss keyboard with touch up background

    public func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    private func dismissKeyboard() {
        view.endEditing(true)
    }


    // MARK: -

    public func isVisible() -> Bool {
        return isViewLoaded && (view.window != nil)
    }
}



