//
//  AppActivityObserverable.swift
//  BaseVCKit
//
//  Created by frank on 2016. 5. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import Foundation


// MARK: - AppActivityObserverable

public enum AppActivityType: String {
    case didBecomeActive = "didBecomeActive", willEnterForeground = "willEnterForeground", didEnterBackground = "didEnterBackground"
}

public protocol AppActivityObserverable: class {
    func addObserver(appActivityTypes: [AppActivityType])
    func removeObserver(appActivityTypes: [AppActivityType])
    func appActivityUpdated(appActivityType: AppActivityType)
}

extension AppActivityObserverable where Self: AnyObject {

    private var appDidBecomeActiveOb: NSObjectProtocol {
        return associatedObject(self, key: "appDidEnterBackgroundObserver", initial: observerInitial(appActivityType: .didBecomeActive))
    }
    private var appWillEnterForegroundOb: NSObjectProtocol {
        return associatedObject(self, key: "appDidEnterBackgroundObserver", initial: observerInitial(appActivityType: .willEnterForeground))
    }
    private var appDidEnterBackgroundOb: NSObjectProtocol {
        return associatedObject(self, key: "appDidEnterBackgroundObserver", initial: observerInitial(appActivityType: .didEnterBackground))
    }

    private func observerInitial(appActivityType: AppActivityType) -> (() -> NSObjectProtocol) {

        let notiName: NSNotification.Name!
        switch appActivityType {
        case .didBecomeActive:
            notiName = NSNotification.Name.UIApplicationDidBecomeActive
        case .willEnterForeground:
            notiName = NSNotification.Name.UIApplicationWillEnterForeground
        case .didEnterBackground:
            notiName = NSNotification.Name.UIApplicationDidEnterBackground
        }

        let using: ((Notification) -> ()) = { [weak self] (notification) in
            self?.appActivityUpdated(appActivityType: appActivityType)
        }

        let initial: () -> NSObjectProtocol = {
            return NotificationCenter.default.addObserver(forName: notiName, object: nil, queue: OperationQueue.main, using: using)
        }
        return initial
    }

    public func addObserver(appActivityTypes: [AppActivityType]) {
        for type in appActivityTypes {
            addObserver(appActivityType: type)
        }
    }

    public func addObserver(appActivityType: AppActivityType) {
        switch appActivityType {
        case .didBecomeActive:
            _ = appDidBecomeActiveOb
        case .willEnterForeground:

            _ = appWillEnterForegroundOb
        case .didEnterBackground:
            print("")
            _ = appDidEnterBackgroundOb
        }
    }

    public func removeObserver(appActivityTypes: [AppActivityType]) {
        for type in appActivityTypes {
            removeObserver(appActivityType: type)
        }
    }

    public func removeObserver(appActivityType: AppActivityType) {
        var ob: NSObjectProtocol!
        switch appActivityType {
        case .didBecomeActive:
            ob = appDidBecomeActiveOb
        case .willEnterForeground:
            ob = appWillEnterForegroundOb
        case .didEnterBackground:
            ob = appDidEnterBackgroundOb
        }
        NotificationCenter.default.removeObserver(ob)
    }

    public func appActivityUpdated(appActivityType: AppActivityType) {}
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

