//
//  UILabelExtensions.swift
//  BaseVCKit
//
//  Created by frank on 2015. 11. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

public extension UILabel {

    public func setAttributedText(fullText: String, highlightText: String, highlightColor: UIColor? = nil, highlightFontWeight: UIFont.Weight? = nil) {
        let range = (fullText as NSString).range(of: highlightText)
        let attributedString = NSMutableAttributedString(string:fullText)

        if let highlightColor = highlightColor { // height color
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: highlightColor , range: range)
        }

        // set bold
        var originFontSize = CGFloat(15)
        if let originFont = self.font {
            originFontSize = originFont.pointSize
        }
        var font = UIFont.systemFont(ofSize: originFontSize, weight: UIFont.Weight.medium)
        if let highlightFontWeight = highlightFontWeight {
            font = UIFont.systemFont(ofSize: originFontSize, weight: highlightFontWeight)
        }
        attributedString.addAttribute(NSAttributedStringKey.font, value: font , range: range)

        self.attributedText = attributedString
    }


    // MARK: - Strikethrough line

    public func renderStrikethrough(text:String?, color:UIColor = UIColor.black) {
        guard let text = text else { return }

        let attributedText = NSMutableAttributedString(string: text , attributes: [NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue, NSAttributedStringKey.strikethroughColor: color])
        attributedText.addAttribute(NSAttributedStringKey.baselineOffset, value: 0, range: NSMakeRange(0, attributedText.length))
        self.attributedText = attributedText
    }


    // MARK: - Ellipse Indecator

    public func startEllipseAnimate(withText txt: String = "")
    {
        defaultTxt = txt
        stopEllipseAnimate()
        ellipseTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
            self.ellipseUpdate(loading: true)
        }
    }

    public func stopEllipseAnimate()
    {
        if let aTimer = ellipseTimer {
            aTimer.invalidate()
            ellipseTimer = nil
        }
        ellipseUpdate(loading: false)
    }

    private struct AssociatedKeys {
        static var ellipseTimerKey = "ellipseTimer"
        static var defaultTxtKey = "defaultTxtKey"
    }

    private var ellipseTimer: Timer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ellipseTimerKey) as? Timer
        }
        set {
            willChangeValue(forKey: "ellipseTimer")
            objc_setAssociatedObject(self, &AssociatedKeys.ellipseTimerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            didChangeValue(forKey: "ellipseTimer")
        }
    }

    private var defaultTxt: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.defaultTxtKey) as? String
        }
        set {
            if let newValue = newValue {
                willChangeValue(forKey: "defaultTxt")
                objc_setAssociatedObject(self, &AssociatedKeys.defaultTxtKey, newValue as NSString?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                didChangeValue(forKey: "defaultTxt")
            }
        }
    }

    private func ellipseUpdate(loading: Bool) {
        guard let defaultTxt = defaultTxt else { return }

        guard loading else {
            self.text = defaultTxt
            return
        }

        if self.text == defaultTxt {
            self.text = defaultTxt + "."
        }else if self.text == defaultTxt + "." {
            self.text = defaultTxt + ".."
        }else if self.text == defaultTxt + ".." {
            self.text = defaultTxt + "..."
        }else {
            self.text = defaultTxt
        }
    }
}
