//
//  UIViewGestureExtensions.swift
//  BaseVCKit
//
//  Created by frank on 2015. 11. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit


public extension UIView {

    typealias TapResponseClosure = (_ tap: UITapGestureRecognizer) -> Void
    typealias PanResponseClosure = (_ pan: UIPanGestureRecognizer) -> Void
    typealias SwipeResponseClosure = (_ swipe: UISwipeGestureRecognizer) -> Void
    typealias PinchResponseClosure = (_ pinch: UIPinchGestureRecognizer) -> Void
    typealias LongPressResponseClosure = (_ longPress: UILongPressGestureRecognizer) -> Void
    typealias RotationResponseClosure = (_ rotation: UIRotationGestureRecognizer) -> Void

    private struct ClosureStorage {
        static var TapClosureStorage: [UITapGestureRecognizer : TapResponseClosure] = [:]
        static var PanClosureStorage: [UIPanGestureRecognizer : PanResponseClosure] = [:]
        static var SwipeClosureStorage: [UISwipeGestureRecognizer : SwipeResponseClosure] = [:]
        static var PinchClosureStorage: [UIPinchGestureRecognizer : PinchResponseClosure] = [:]
        static var LongPressClosureStorage: [UILongPressGestureRecognizer: LongPressResponseClosure] = [:]
        static var RotationClosureStorage: [UIRotationGestureRecognizer: RotationResponseClosure] = [:]
    }

    private struct Swizzler {
        // TODO: - Check later
        // private static var OnceToken : dispatch_once_t = 0
        static func Swizzle() {
            // dispatch_once(&OnceToken) {
            let UIViewClass: AnyClass! = NSClassFromString("UIView")
            let originalSelector = #selector(UIView.removeFromSuperview)
            let swizzleSelector = #selector(UIView.swizzled_removeFromSuperview)
            let original: Method = class_getInstanceMethod(UIViewClass, originalSelector)!
            let swizzle: Method = class_getInstanceMethod(UIViewClass, swizzleSelector)!
            method_exchangeImplementations(original, swizzle)
            // }
        }

        static var Swizzled: Bool = {
            let UIViewClass: AnyClass! = NSClassFromString("UIView")
            let originalSelector = #selector(UIView.removeFromSuperview)
            let swizzleSelector = #selector(UIView.swizzled_removeFromSuperview)
            let original: Method = class_getInstanceMethod(UIViewClass, originalSelector)!
            let swizzle: Method = class_getInstanceMethod(UIViewClass, swizzleSelector)!
            return true
            }()
    }

    @objc public func swizzled_removeFromSuperview() {
        self.removeGestureRecognizersFromStorage()
        /*
        Will call the original representation of removeFromSuperview, not endless cycle:
        http://darkdust.net/writings/objective-c/method-swizzling
        */
        self.swizzled_removeFromSuperview()
    }

    public func removeGestureRecognizersFromStorage() {
        if let gestureRecognizers = self.gestureRecognizers {
            for recognizer: UIGestureRecognizer in gestureRecognizers as [UIGestureRecognizer] {
                if let tap = recognizer as? UITapGestureRecognizer {
                    ClosureStorage.TapClosureStorage[tap] = nil
                }
                else if let pan = recognizer as? UIPanGestureRecognizer {
                    ClosureStorage.PanClosureStorage[pan] = nil
                }
                else if let swipe = recognizer as? UISwipeGestureRecognizer {
                    ClosureStorage.SwipeClosureStorage[swipe] = nil
                }
                else if let pinch = recognizer as? UIPinchGestureRecognizer {
                    ClosureStorage.PinchClosureStorage[pinch] = nil
                }
                else if let rotation = recognizer as? UIRotationGestureRecognizer {
                    ClosureStorage.RotationClosureStorage[rotation] = nil
                }
                else if let longPress = recognizer as? UILongPressGestureRecognizer {
                    ClosureStorage.LongPressClosureStorage[longPress] = nil
                }
            }
        }
    }

    // MARK: Taps

    public func addSingleTapGestureRecognizerWithResponder(responder: @escaping TapResponseClosure) {
        self.addTapGestureRecognizerForNumberOfTaps(withResponder: responder)
    }

    public func addDoubleTapGestureRecognizerWithResponder(responder: @escaping TapResponseClosure) {
        self.addTapGestureRecognizerForNumberOfTaps(numberOfTaps: 2, withResponder: responder)
    }

    public func addTapGestureRecognizerForNumberOfTaps(
        numberOfTaps: Int = 1,
        numberOfTouches: Int = 1,
        withResponder responder: @escaping TapResponseClosure
        ) {
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = numberOfTaps
        tap.numberOfTouchesRequired = numberOfTouches
        tap.addTarget(self, action: #selector(UIView.handleTap(sender:)))
        self.addGestureRecognizer(tap)

        if !self.isUserInteractionEnabled { self.isUserInteractionEnabled = true }

        ClosureStorage.TapClosureStorage[tap] = responder
        Swizzler.Swizzle()
    }

    @objc public func handleTap(sender: UITapGestureRecognizer) {
        if let closureForTap = ClosureStorage.TapClosureStorage[sender] {
            closureForTap(sender)
        }
    }

    // MARK: Pans
    public func addSingleTouchPanGestureRecognizerWithResponder(responder: @escaping PanResponseClosure) {
        self.addPanGestureRecognizerForNumberOfTouches(numberOfTouches: 1, withResponder: responder)
    }

    public func addDoubleTouchPanGestureRecognizerWithResponder(responder: @escaping PanResponseClosure) {
        self.addPanGestureRecognizerForNumberOfTouches(numberOfTouches: 2, withResponder: responder)
    }

    public func addPanGestureRecognizerForNumberOfTouches(numberOfTouches: Int, withResponder responder: @escaping PanResponseClosure) {
        let pan = UIPanGestureRecognizer()
        pan.minimumNumberOfTouches = numberOfTouches
        pan.addTarget(self, action: #selector(UIView.handlePan(sender:)))
        self.addGestureRecognizer(pan)

        ClosureStorage.PanClosureStorage[pan] = responder
        Swizzler.Swizzle()
    }

    @objc public func handlePan(sender: UIPanGestureRecognizer) {
        if let closureForPan = ClosureStorage.PanClosureStorage[sender] {
            closureForPan(sender)
        }
    }


    // MARK: Swipes

    public func addLeftSwipeGestureRecognizerWithResponder(responder: @escaping SwipeResponseClosure) {
        self.addLeftSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: 1, withResponder: responder)
    }

    public func addLeftSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: Int, withResponder responder: @escaping SwipeResponseClosure) {
        self.addSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: numberOfTouches, forSwipeDirection: .left, withResponder: responder)
    }

    public func addRightSwipeGestureRecognizerWithResponder(responder: @escaping SwipeResponseClosure) {
        self.addRightSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: 1, withResponder: responder)
    }

    public func addRightSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: Int, withResponder responder: @escaping SwipeResponseClosure) {
        self.addSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: numberOfTouches, forSwipeDirection: .right, withResponder: responder)
    }

    public func addUpSwipeGestureRecognizerWithResponder(responder: @escaping SwipeResponseClosure) {
        self.addUpSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: 1, withResponder: responder)
    }

    public func addUpSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: Int, withResponder responder: @escaping SwipeResponseClosure) {
        self.addSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: numberOfTouches, forSwipeDirection: .up, withResponder: responder)
    }

    public func addDownSwipeGestureRecognizerWithResponder(responder: @escaping SwipeResponseClosure) {
        self.addDownSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: 1, withResponder: responder)
    }

    public func addDownSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: Int, withResponder responder: @escaping SwipeResponseClosure) {
        self.addSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: numberOfTouches, forSwipeDirection: .down, withResponder: responder)
    }

    public func addSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: Int, forSwipeDirection swipeDirection: UISwipeGestureRecognizer.Direction, withResponder responder: @escaping SwipeResponseClosure) {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = swipeDirection
        swipe.numberOfTouchesRequired = numberOfTouches
        swipe.addTarget(self, action: #selector(UIView.handleSwipe(sender:)))
        self.addGestureRecognizer(swipe)

        ClosureStorage.SwipeClosureStorage[swipe] = responder
        Swizzler.Swizzle()
    }

    @objc public func handleSwipe(sender: UISwipeGestureRecognizer) {
        if let closureForSwipe = ClosureStorage.SwipeClosureStorage[sender] {
            closureForSwipe(sender)
        }
    }


    // MARK: Pinches

    public func addPinchGestureRecognizerWithResponder(responder: @escaping PinchResponseClosure) {
        let pinch = UIPinchGestureRecognizer()
        pinch.addTarget(self, action: #selector(UIView.handlePinch(sender:)))
        self.addGestureRecognizer(pinch)

        ClosureStorage.PinchClosureStorage[pinch] = responder
        Swizzler.Swizzle()
    }

    @objc public func handlePinch(sender: UIPinchGestureRecognizer) {
        if let closureForPinch = ClosureStorage.PinchClosureStorage[sender] {
            closureForPinch(sender)
        }
    }


    // MARK: LongPress

    public func addLongPressGestureRecognizerWithResponder(responder: @escaping LongPressResponseClosure) {
        self.addLongPressGestureRecognizerForNumberOfTouches(numberOfTouches: 1, withResponder: responder)
    }

    public func addLongPressGestureRecognizerForNumberOfTouches(numberOfTouches: Int, withResponder responder: @escaping LongPressResponseClosure) {
        let longPress = UILongPressGestureRecognizer()
        longPress.numberOfTouchesRequired = numberOfTouches
        longPress.addTarget(self, action: #selector(UIView.handleLongPress(sender:)))
        self.addGestureRecognizer(longPress)

        ClosureStorage.LongPressClosureStorage[longPress] = responder
        Swizzler.Swizzle()
    }

    @objc public func handleLongPress(sender: UILongPressGestureRecognizer) {
        if let closureForLongPinch = ClosureStorage.LongPressClosureStorage[sender] {
            closureForLongPinch(sender)
        }
    }


    // MARK: Rotation

    public func addRotationGestureRecognizerWithResponder(responder: @escaping RotationResponseClosure) {
        let rotation = UIRotationGestureRecognizer()
        rotation.addTarget(self, action: #selector(UIView.handleRotation(sender:)))
        self.addGestureRecognizer(rotation)

        ClosureStorage.RotationClosureStorage[rotation] = responder
        Swizzler.Swizzle()
    }

    @objc public func handleRotation(sender: UIRotationGestureRecognizer) {
        if let closureForRotation = ClosureStorage.RotationClosureStorage[sender] {
            closureForRotation(sender)
        }
    }


    // MARK: -

    public var hasTabRecognizer: Bool {
        get {
            if let gestureRecognizers = self.gestureRecognizers {
                for recognizer: UIGestureRecognizer in gestureRecognizers as [UIGestureRecognizer] {
                    if let _ = recognizer as? UITapGestureRecognizer {
                        return true
                    }
                }
            }
            return false
        }
    }
}
