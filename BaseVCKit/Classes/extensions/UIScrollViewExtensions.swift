//
//  UIScrollViewExtensions.swift
//  BaseVCKit
//
//  Created by frank on 2015. 11. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

public extension UIScrollView {
    public var currentPage:Int{
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)+1
    }
}
