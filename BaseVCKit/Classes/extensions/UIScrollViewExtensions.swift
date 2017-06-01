//
//  UIScrollViewExtensions.swift
//  FrankUIKit
//
//  Created by frank on 2015. 11. 10..
//  Copyright © 2015년 treetopworks. All rights reserved.
//

import UIKit

extension UIScrollView {
    public var currentPage:Int{
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)+1
    }
}
