//
//  ProfileImageView.swift
//  BaseVCKit
//
//  Created by frank on 2016. 5. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit
import Kingfisher

public class ProfileImageView: UIView {

    public var url: URL? {
        didSet {
            if let url = url {
                imgView.kf.setImage(with: url, placeholder: placeHolderIcon)
            }else {
                let url_: URL! = URL(string: "")
                imgView.kf.setImage(with: url_, placeholder: placeHolderIcon)
            }
        }
    }
    public var path: String? {
        didSet {
            var newUrl = URL(string: "")
            if let path = self.path { newUrl = URL(string: path) }
            url = newUrl
        }
    }
    public var newImage: UIImage? { // for update profile image
        didSet {
            if let newImage = newImage {
                imgView.image = newImage
            }else {
                path = ""
            }
        }
    }
    public var customCornerRadius: CGFloat? {
        didSet {
            setNeedsDisplay()
        }
    }

    private var externalBorderWidth: CGFloat = 0
    private var externalBorderColor: UIColor = UIColor.white

    private var bgColor: UIColor
    private var placeHolderIcon: UIImage
    public init(bgColor bgColor_: UIColor, placeHolderIcon placeHolderIcon_: UIImage) {

        bgColor = bgColor_
        placeHolderIcon = placeHolderIcon_
        super.init(frame: CGRect.zero)

        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private lazy var imgView: UIImageView = { [unowned self] in
        let v = UIImageView.init()
        v.contentMode = UIViewContentMode.scaleAspectFill
        self.addSubview(v)
        return v
    }()
    private lazy var imgMaskLayer: CAShapeLayer = { [unowned self] in
        let l = CAShapeLayer()
        return l
    }()
    private lazy var externalBorder: CALayer = { [unowned self] in
        let l = CALayer()
        self.layer.insertSublayer(l, at: 0)
        return l
    }()

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if externalBorderWidth > 0 {
            let width = frame.size.width + 2 * externalBorderWidth
            let height = frame.size.height + 2 * externalBorderWidth
            externalBorder.frame = CGRect(x: -externalBorderWidth, y: -externalBorderWidth, width: width, height: height)
            externalBorder.borderColor = externalBorderColor.cgColor
            externalBorder.borderWidth = externalBorderWidth
            externalBorder.cornerRadius = (rect.height + 2 * externalBorderWidth) / 2
            layer.masksToBounds = false
        }

        if let customCornerRadius = customCornerRadius {
            let roundRectPath = UIBezierPath(roundedRect: rect, cornerRadius: customCornerRadius)
            imgMaskLayer.path = roundRectPath.cgPath
        }else {
            let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: rect.maxX, height: rect.maxY))
            imgMaskLayer.path = circlePath.cgPath
        }

        imgMaskLayer.fillColor = UIColor.black.cgColor
        imgView.layer.mask = imgMaskLayer
        imgView.backgroundColor = bgColor
    }


    // MARK: - Init

    private func commonInit() {
//        clipsToBounds = true
        backgroundColor = UIColor.clear

        url = nil

        configureConstraints()
    }


    // MARK: - Layout

    private func configureConstraints() {
        imgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }


    // MARK: - Public methods

    public func setExternalBorderWithColor(borderColor: UIColor, borderWidth: CGFloat) {
        externalBorderColor = borderColor
        externalBorderWidth = borderWidth
        setNeedsDisplay()
    }
}
