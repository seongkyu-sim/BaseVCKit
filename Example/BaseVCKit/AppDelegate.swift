//
//  AppDelegate.swift
//  BaseVCKit
//
//  Created by seongkyu-sim on 04/19/2017.
//  Copyright (c) 2017 seongkyu-sim. All rights reserved.
//

import UIKit
import BaseVCKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        if let w = window {
            w.backgroundColor = UIColor.white
            w.rootViewController = CustomTabbar.tabVC
            w.makeKeyAndVisible()
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


// MARK: - 

public enum CustomTabbar {
    case home, editor, setting
    
    public static var tabVC: UITabBarController {
        return TabbarVCGenerator.tabVC(menuSpecs: self.allTabMenuSpec)
    }

    static var allTabMenuSpec: [TabbarVCGenerator.TabMenuSpec] {
        return [self.home, self.editor, self.setting].map{ $0.toMenuSpec }
    }

    var toMenuSpec: TabbarVCGenerator.TabMenuSpec {

        var systemItem: UITabBarSystemItem!
        var vc: UIViewController!
        switch self {
        case .home:
            vc = ViewController()
            systemItem = .search
        case .editor:
            vc = EditorVC()
            systemItem = .bookmarks
        case .setting:
            vc = ViewController2()
            systemItem = .history
        }
        return TabbarVCGenerator.TabMenuSpec(viewController: vc, systemItem: systemItem)
    }
}

