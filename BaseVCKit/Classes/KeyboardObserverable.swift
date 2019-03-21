//
//  KeyboardObserverable.swift
//  BaseVCKit
//
//  Created by frank on 2017. 4. 19..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit
import SnapKit

/**
 * This protoco is for UIViewController
 */

public protocol KeyboardObserverable: class {
    func willAnimateKeyboard(keyboardTargetHeight: CGFloat, duration: Double, animationType: UIView.AnimationOptions)
    func willChangeKeyboard(height: CGFloat)
}

private var keyboardChangeObserverKey = "keyboardChangeObserver"

extension KeyboardObserverable where Self: UIViewController {

    private var keyboardOb: NSObjectProtocol? {
        get {
            return objc_getAssociatedObject(self, &keyboardChangeObserverKey) as? NSObjectProtocol
        }
        set {
            willChangeValue(forKey: keyboardChangeObserverKey)
            if newValue == nil {
                // to clear observer
                objc_setAssociatedObject(self, &keyboardChangeObserverKey, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            }else {
                objc_setAssociatedObject(self, &keyboardChangeObserverKey, newValue as NSObjectProtocol?, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            }
            didChangeValue(forKey: keyboardChangeObserverKey)
        }
    }

    public func startKeyboardAnimationObserveWithViewWillAppear() {

        keyboardOb = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: OperationQueue.main,
            using: { [weak self] (notification) in
                guard let userInfo = notification.userInfo,
                    let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
                    let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
                    let c = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
                    let keyboardFrame = self?.view.convert(frame, from: nil),
                    let viewBounds = self?.view.bounds else {
                        return
                }

                let newBottomOffset = viewBounds.maxY - keyboardFrame.minY
                let animationType: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: c)
                self?.willAnimateKeyboard(keyboardTargetHeight: newBottomOffset, duration: duration, animationType: animationType)
                self?.willChangeKeyboard(height: newBottomOffset)
        })
    }

    public func stopKeyboardAnimationObserveWithViewWillDisAppear() {

        self.view.endEditing(true) // make dismiss keyboard before UIViewController
        if let ob = keyboardOb {
            NotificationCenter.default.removeObserver(ob)
            keyboardOb = nil
        }
    }

    public func willAnimateKeyboard(keyboardTargetHeight: CGFloat, duration: Double, animationType: UIView.AnimationOptions) {}
    public func willChangeKeyboard(height: CGFloat) {}
}

// + SnapKit
public protocol KeyboardSanpable: KeyboardObserverable {

    // set keyboardFollowView as 'done button' or 'text input'
    var keyboardFollowView: UIView? { get }

    // set keyboardFollowOffsetForAppeared, keyboardFollowOffsetForDisappeared for vertical interval keyboardFollowView with Keyboard's top
    var keyboardFollowOffsetForAppeared: CGFloat { get }
    var keyboardFollowOffsetForDisappeared: CGFloat { get }

    func keyboardFollowViewUpdateContraintsAnimations(keyboardTargetHeight: CGFloat) -> (()->())?
    func keyboardFollowViewUpdateContraintsAnimationCompleted(finished: Bool)
}

extension KeyboardSanpable where Self: UIViewController {

    public var keyboardFollowView: UIView? { return nil }
    public var keyboardFollowOffsetForAppeared: CGFloat { return 0 }
    public var keyboardFollowOffsetForDisappeared: CGFloat { return 0 }

    public func willAnimateKeyboard(keyboardTargetHeight: CGFloat, duration: Double, animationType: UIView.AnimationOptions) {
        guard let animations = self.keyboardFollowViewUpdateContraintsAnimations(keyboardTargetHeight: keyboardTargetHeight) else { return }

        UIView.animate(withDuration: duration, delay: 0.0, options: animationType, animations: animations) { [unowned self] (finished) in
            self.keyboardFollowViewUpdateContraintsAnimationCompleted(finished: finished)
        }
    }

    public func keyboardFollowViewUpdateContraintsAnimations(keyboardTargetHeight: CGFloat) -> (()->())? {
        guard let _ = self.view.window else { return nil } // isVisible
        guard let v = keyboardFollowView, !v.constraints.isEmpty else { return nil }

        let isAppear: Bool = keyboardTargetHeight != 0
        let followViewIntervalV = isAppear ? keyboardFollowOffsetForAppeared : keyboardFollowOffsetForDisappeared
        let bottomOffset = keyboardTargetHeight + followViewIntervalV

        let animations: () -> () = {
            v.snp.updateConstraints({ (make) in
                make.bottom.equalToSuperview().offset(-bottomOffset)
            })
            v.superview?.layoutIfNeeded()
        }
        return animations
    }
    public func keyboardFollowViewUpdateContraintsAnimationCompleted(finished: Bool) {}
}
