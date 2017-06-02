//
//  UIButtonExtensions.swift
//  BaseVCKit
//
//  Created by frank on 2017. 5. 31..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

fileprivate let intervalImageBetweenText: CGFloat = 6

public extension UIButton {

    // MARK: - Configure Helper

    public static func configure(image: UIImage?,
                    title: String?,
                    titleColor: UIColor = .white,
                    fontSize: CGFloat = 14,
                    fontWeight: CGFloat = UIFontWeightLight ,
                    bgColor: UIColor = .clear,
                    cornerRadius: CGFloat = 0) -> UIButton {

        let btn = UIButton(type: .custom)
        btn.setImage(image, for: .normal)
        btn.setTitle(title, for: UIControlState.normal)
        btn.titleLabel!.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        btn.setRoundCorner(radius: cornerRadius)
        btn.setStatesTitleColor(withNormalColor: titleColor)
        btn.setStatesBackground(withNormalColor: bgColor)

        if let _ = image, let _ = title {
            btn.imageEdgeInsets.right = intervalImageBetweenText/2
            btn.titleEdgeInsets.left = intervalImageBetweenText/2
        }
        return btn
    }


    // MARK: - Background color

    public func setStatesBackground(withNormalColor color: UIColor) {
        self.setBackground(color: color, state: .normal)
        self.setBackground(color: color.withRecursiveAlphaComponent(0.7), state: .highlighted)
        self.setBackground(color: color, state: .disabled)
    }

    public func setBackground(color: UIColor, state: UIControlState) {
        self.setBackgroundImage(image(withColor: color), for: state)
    }

    private func image(withColor color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }


    // MARK: - Title color

    public func setStatesTitleColor(withNormalColor color: UIColor) {
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(color, for: .highlighted)
        self.setTitleColor(color.withRecursiveAlphaComponent(0.3), for: .disabled)
    }


    // MARK: - Min Bounds

    /**
     * Should set image and title before call 'minSize'
     */
    public var minSize: CGSize {
        guard let _ = title(for: .normal) else {
            return CGSize(width: 21, height: 21) // icon only
        }

        let marginH: CGFloat = 8
        var w: CGFloat = marginH*2
        if let img = image(for: .normal) {
            w += intervalImageBetweenText
            w += img.size.width
        }
        w += self.titleLabel!.intrinsicContentSize.width
        return CGSize(width: w, height: 30)
    }
}
