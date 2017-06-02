//
//  UITabbarExtensions.swift
//  BaseVCKit
//
//  Created by frank on 2015. 11. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

public extension UITabBar {

    public func showDot(itemIndex index: Int, color: UIColor? = UIColor.red) {

        let dotRadius = CGFloat(3)
        let tabItemW = self.items == nil ? self.frame.size.width : self.frame.size.width / CGFloat(self.items!.count)
        let centerX = tabItemW * CGFloat(index) + tabItemW/2
        let dot = UIView(frame: CGRect(x: centerX - dotRadius, y: self.frame.size.height - dotRadius, width: dotRadius * 2, height: dotRadius * 2))
        dot.tag = 888
        dot.backgroundColor = color
        dot.setRoundCorner(radius: dotRadius)

        self.addSubview(dot)
    }

    public func hideDot(itemIndex index: Int) {
        if let foundView = self.viewWithTag(888) {
            foundView.removeFromSuperview()
        }
    }
}

