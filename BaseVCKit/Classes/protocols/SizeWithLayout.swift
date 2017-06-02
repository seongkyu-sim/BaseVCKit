//
//  SizeWithLayout.swift
//  BaseVCKit
//
//  Created by frank on 2016. 5. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

/**
 * For get size of UI element with 'initSubViewConstraints()'
 */
public protocol SizeWithLayout: class {}
extension SizeWithLayout where Self: UIView {
    public var size: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        return self.bounds.size
    }
}
