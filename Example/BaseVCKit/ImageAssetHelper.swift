//
//  ImageAssets.swift
//  FrankUIKit
//
//  Created by frank on 2015. 11. 10..
//  Copyright © 2015년 treetopworks. All rights reserved.
//

import UIKit

public class ImageAssets: NSObject {

    public class var arrowLeftIcon: UIImage             { return ImageAssets.bundledImage(named: "arrowLeft") }

    internal class func bundledImage(named name: String) -> UIImage {
        let bundle = Bundle(for: ImageAssets.self)
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        if let image = image {
            return image
        }
        return UIImage()
    }
}
