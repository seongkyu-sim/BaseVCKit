//
//  UILableExtensions.swift
//  Pods
//
//  Created by frank on 2017. 7. 20..
//
//

import UIKit

extension UILabel {

    public static func configureLabel(color:UIColor, size:CGFloat, weight: CGFloat = UIFont.Weight.regular.rawValue) -> UILabel {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight(rawValue: weight))
        label.textColor = color
        label.numberOfLines = 0
        return label
    }
}
