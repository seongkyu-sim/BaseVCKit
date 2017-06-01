//
//  UIImageExtensions.swift
//  FrankUIKit
//
//  Created by frank on 2015. 11. 10..
//  Copyright © 2015년 treetopworks. All rights reserved.
//

import UIKit

extension UIImage {

    public func image(withColor color: UIColor) -> UIImage {
        let newImage = image(withColor: color, size: self.size)
        return newImage
    }

    public func image(withColor color: UIColor, width: CGFloat) -> UIImage {
        let originSize = self.size
        let height = originSize.height * width / originSize.width
        let newSize = CGSize(width: width, height: height)
        return self.image(withColor: color, size: newSize)
    }

    public func image(withColor color: UIColor, height: CGFloat) -> UIImage {
        let originSize = self.size
        let width = originSize.width * height / originSize.height
        let newSize = CGSize(width: width, height: height)
        return self.image(withColor: color, size: newSize)
    }

    public func image(withColor color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        color.setFill()

        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: self.cgImage!)
        context.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()

        return newImage
    }


    // MARK: - Make space in imageView.rect's inside

    public func image(withSpaceInsets insets: UIEdgeInsets) -> UIImage {
        let origImage = self
        let size = CGSize(width: origImage.size.width + insets.left + insets.right, height: origImage.size.height + insets.top + insets.bottom)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let rect = CGRect(x: insets.left, y: insets.top, width: origImage.size.width, height: origImage.size.height)
        origImage.draw(in: rect)
        let spaceInsetsImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return spaceInsetsImage!
    }


    // MARK: - Resizing: reduce file size

    public func image(resizeRate rate: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * rate, height: size.height * rate)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }

    public func image(resizeWidth width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
