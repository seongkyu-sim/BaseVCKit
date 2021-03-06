//
//  UITextFieldExtensions.swift
//  BaseVCKit
//
//  Created by frank on 2015. 11. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

public extension UITextField {
    
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

    func setUnderlineOnly(color: UIColor, width: CGFloat = 1) {
        if underLine == nil {
            self.borderStyle = UITextField.BorderStyle.none
            self.backgroundColor = UIColor.clear
            underLine = UIView()
            self.addSubview(underLine!)
        }
        underLine!.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        underLine?.backgroundColor = color
    }
}
