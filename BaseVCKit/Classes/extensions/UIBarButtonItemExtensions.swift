//
//  UIBarButtonItemExtensions.swift
//  Pods
//
//  Created by frank on 2017. 7. 4..
//
//

import UIKit

public typealias CKBarButtonHandler = (_ sender: UIBarButtonItem) -> Void

// A global var to produce a unique address for the assoc object handle
private var associatedEventHandle: UInt8 = 0

extension UIBarButtonItem {

    private var closuresWrapper: ClosureWrapper? {
        get {
            return objc_getAssociatedObject(self, &associatedEventHandle) as? ClosureWrapper
        }
        set {
            objc_setAssociatedObject(self, &associatedEventHandle, newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /**
     Initializes an UIBarButtonItem that will call the given closure when the button is touched.
     :param: image   The item’s image. If nil an image is not displayed.
     :param: style   The style of the item. One of the constants defined in UIBarButtonItemStyle.
     :param: handler The closure which handles button touches.
     :returns: an initialized instance of UIBarButtonItem.
     */
    public convenience init(image: UIImage?, style: UIBarButtonItem.Style, handler: @escaping CKBarButtonHandler) {
        self.init(image: image, style: style, target: nil, action: #selector(UIBarButtonItem.handleAction))
        self.closuresWrapper = ClosureWrapper(handler: handler)
        self.target = self
    }

    public convenience init(systemItem: UIBarButtonItem.SystemItem, handler: @escaping CKBarButtonHandler) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: #selector(UIBarButtonItem.handleAction))
        self.closuresWrapper = ClosureWrapper(handler: handler)
        self.target = self
    }

    // MARK: Private methods

    @objc
    private func handleAction() {
        self.closuresWrapper?.handler(self)
    }
}

// MARK: - Private classes

private final class ClosureWrapper {
    var handler: CKBarButtonHandler

    init(handler: @escaping CKBarButtonHandler) {
        self.handler = handler
    }
}
