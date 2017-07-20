//
//  UILableExtensions.swift
//  Pods
//
//  Created by frank on 2017. 7. 20..
//
//

import UIKit

extension UILabel {

    public static func configureLabel(color:UIColor, size:CGFloat, weight: CGFloat = UIFontWeightRegular) -> UILabel {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textColor = color
        label.numberOfLines = 0
        return label
    }
}
