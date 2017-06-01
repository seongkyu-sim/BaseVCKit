//
//  UITextFieldExtensions.swift
//  FrankUIKit
//
//  Created by frank on 2015. 11. 10..
//  Copyright © 2015년 treetopworks. All rights reserved.
//

import UIKit

extension UITextField
{
    private struct AssociatedKeys {
        static var underLineKey = "underLine"
    }

    private var underLine: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.underLineKey) as? UIView
        }
        set {
            willChangeValue(forKey: "underLine")
            objc_setAssociatedObject(self, &AssociatedKeys.underLineKey, newValue as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            didChangeValue(forKey: "underLine")
        }
    }

    public func setUnderlineOnly(color: UIColor, width: CGFloat = 1) {
        if underLine == nil {
            self.borderStyle = UITextBorderStyle.none
            self.backgroundColor = UIColor.clear
            underLine = UIView()
            self.addSubview(underLine!)
        }
        underLine!.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1)
        }
        underLine?.backgroundColor = color
    }
}
