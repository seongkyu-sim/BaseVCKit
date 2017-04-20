//
//  KeyboardObserverable.swift
//  Pods
//
//  Created by frank on 2017. 4. 19..
//
//

import UIKit
import SnapKit

/**
 * This protoco is for UIViewController
 */

public protocol KeyboardObserverable: class {
    func addKeyboardAnimationObserver()
    func removeKeyboardAnimationObserver()
    func willAnimateKeyboard(keyboardTargetHeight: CGFloat, duration: Double, animationType: UIViewAnimationOptions)
}

extension KeyboardObserverable where Self: UIViewController {

    private var keyboardOb: NSObjectProtocol {
        return associatedObject(self, key: "keyboardAnimationObserver", initial: keyboardObInitial)
    }

    private func keyboardObInitial() -> NSObjectProtocol {
        let ob = NotificationCenter.default.addObserver(
            forName: NSNotification.Name.UIKeyboardWillChangeFrame,
            object: nil,
            queue: OperationQueue.main,
            using: { [weak self] (notification) in
                if let userInfo = notification.userInfo,
                    let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
                    let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
                    let c = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt,
                    let keyboardFrame = self?.view.convert(frame, from: nil),
                    let viewBounds = self?.view.bounds {
                    let newBottomOffset = viewBounds.maxY - keyboardFrame.minY
                    let animationType: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: c)
                    self?.willAnimateKeyboard(keyboardTargetHeight: newBottomOffset, duration: duration, animationType: animationType)
                } else {
                    print("!!! Invalid conditions for UIKeyboardWillChangeFrameNotification")
                }
        })
        return ob
    }

    public func addKeyboardAnimationObserver() {
        _ = keyboardOb
    }

    public func removeKeyboardAnimationObserver() {
        NotificationCenter.default.removeObserver(keyboardOb)
    }

    public func willAnimateKeyboard(keyboardTargetHeight: CGFloat, duration: Double, animationType: UIViewAnimationOptions) {}
}

// Association
private func associatedObject<T: AnyObject>(_ host: AnyObject, key: UnsafeRawPointer, initial: () -> T) -> T {
    var value = objc_getAssociatedObject(host, key) as? T
    if value == nil {
        value = initial()
        objc_setAssociatedObject(host, key, value, .OBJC_ASSOCIATION_RETAIN)
    }
    return value!
}


// + SnapKit
public protocol KeyboardSanpable: KeyboardObserverable {

    // set keyboardFollowView as 'done button' or 'text input'
    var keyboardFollowView: UIView? { get }

    // set keyboardFollowOffset for vertical interval keyboardFollowView with Keyboard's top
    var keyboardFollowOffset: CGFloat { get }

    func keyboardFollowViewUpdateContraintsAnimations(keyboardTargetHeight: CGFloat) -> (()->())?
    func keyboardFollowViewUpdateContraintsAnimationCompleted(finished: Bool)
}

extension KeyboardSanpable where Self: UIViewController {

    public var keyboardFollowView: UIView? { return nil }
    public var keyboardFollowOffset: CGFloat { return 0 }

    public func willAnimateKeyboard(keyboardTargetHeight: CGFloat, duration: Double, animationType: UIViewAnimationOptions) {
        guard let animations = self.keyboardFollowViewUpdateContraintsAnimations(keyboardTargetHeight: keyboardTargetHeight) else { return }

        UIView.animate(withDuration: duration, delay: 0.0, options: animationType, animations: animations) { [unowned self] (finished) in
            self.keyboardFollowViewUpdateContraintsAnimationCompleted(finished: finished)
        }
    }

    public func keyboardFollowViewUpdateContraintsAnimations(keyboardTargetHeight: CGFloat) -> (()->())? {
        guard let v = keyboardFollowView, !v.constraints.isEmpty else { return nil }

        let animations: () -> () = {
            let bottomOffset = -(keyboardTargetHeight + self.keyboardFollowOffset)
            v.snp.updateConstraints({ (make) in
                make.bottom.equalToSuperview().offset(bottomOffset)
            })
            v.superview?.layoutIfNeeded()
        }
        return animations
    }

    public func keyboardFollowViewUpdateContraintsAnimationCompleted(finished: Bool) {}
}
