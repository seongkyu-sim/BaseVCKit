//
//  UIViewExtensions.swift
//  BaseVCKit
//
//  Created by frank on 2015. 11. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

public extension UIView {

    public var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    public func setRoundCorner(radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }

    public func setBorder(color: UIColor, width: CGFloat = 0.5) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
