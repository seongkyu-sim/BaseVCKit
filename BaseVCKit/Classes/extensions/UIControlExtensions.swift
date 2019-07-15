//
//  UIControlExtensions.swift
//  BaseVCKit
//
//  Created by frank on 2017. 5. 31..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

// a proxy class
public class TargetActionProxy: UIView {
    // a block that will be called
    public var _action: (AnyObject) -> ()

    public init(controlEvents: UIControl.Event, action: @escaping (AnyObject) -> ()) {
        _action = action
        super.init(frame: CGRect.zero)
        self.tag = Int(controlEvents.rawValue)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc public func action(_ sender: AnyObject) {
        _action(sender)
    }
}

public extension UIControl {

    /**
     A helper method that allows a UIControl subclass to perform a block when a controlEvent is recieved
     Use this method for your UIControl subclass if you are using objective-c
     - parameter controlEvents: The control events that you want to trigger the closure
     - parameter action: a closure that will be executed when it recieves the given control events.
     */
    @objc
    func addHandler(events: UIControl.Event, action: @escaping (AnyObject) -> ())
    {
        callback(when: events, with: action)
    }

}

extension UIControl: CallBackTargetAction {}

public protocol CallBackTargetAction {}

extension CallBackTargetAction where Self: UIControl {

    /**
     A helper method that allows a UIControl subclass to perform a block when a controlEvent is recieved
     - parameter controlEvents: The control events that you want to trigger the closure
     - parameter action: a closure that will be executed when it recieves the given control events.
     */
    public func callback(when controlEvents: UIControl.Event = [UIControl.Event.touchUpInside],
                         with action: @escaping (Self) -> ())
    {
        // An array of supported touch events
        let ctrlEvts: [UIControl.Event] = [
            .touchDown,
            .touchDownRepeat,
            .touchDragInside,
            .touchDragOutside,
            .touchDragEnter,
            .touchDragExit,
            .touchUpInside,
            .touchUpOutside,
            .touchCancel,
            .valueChanged,
            .editingDidBegin,
            .editingChanged,
            .editingDidEnd,
            .editingDidEndOnExit
        ]

        ctrlEvts.forEach {
            if controlEvents.contains($0) {
                // each touch event requires its own proxy object
                _addActionToView(tag: $0.rawValue, action: { (ao: AnyObject) -> () in
                    action(ao as! Self)
                })
            }
        }
    }

    private func _addActionToView(tag: UInt, action: @escaping (AnyObject) -> ()) {
        let foo = TargetActionProxy(controlEvents: UIControl.Event(rawValue: tag), action: action)
        // remove previous if it exists
        viewWithTag(Int(tag))?.removeFromSuperview()
        // since foo is not retained by target(_, action:, forControlEvents:) we must save it somewhere.  This implementation saves it as a subview.
        self.addSubview(foo)
        // add target to button.  Target instance is a proxy object and it calls a selector beloing to that proxy object.
        addTarget(foo, action: #selector(TargetActionProxy.action(_:)), for: UIControl.Event(rawValue: tag))
    }
}
