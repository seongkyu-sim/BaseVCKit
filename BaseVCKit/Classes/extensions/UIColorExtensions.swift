//
//  UIColorExtensions.swift
//  BaseVCKit
//
//  Created by frank on 2017. 6. 2..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

public extension UIColor {
    public func withRecursiveAlphaComponent(_ alphaComponent: CGFloat) -> UIColor {
        var resultColor = self.withAlphaComponent(alphaComponent)
        if let oldComponent = self.cgColor.components?.last, oldComponent != 1 { // transparency color
            resultColor = self.withAlphaComponent(oldComponent * alphaComponent)
        }
        return resultColor
    }
}
