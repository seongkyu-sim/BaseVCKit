//
//  NavButtonConfigurableTest.swift
//  BaseVCKit
//
//  Created by frank on 2017. 4. 24..
//  Copyright © 2017년 CocoaPods. All rights reserved.
//

import XCTest
@testable import BaseVCKit_Example


class NavButtonConfigurableTest: XCTestCase {

    /** should test below
     *
     * <root>
     * 1. VC with single on KeyWindow
     * 2. VC with wrapped with NVC
     * 3. VC with warpped with TabVC
     *
     * <drilled>
     *
     * <modal>
     */

    var sut: UITabBarController!

    override func setUp() {
        super.setUp()

        sut = CustomTabbar.tabVC
        // load view hierarchy
        let _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func test_TabItemCount_IsTwo() {
        // GIVEN
        let vcCount = sut.viewControllers?.count
        // WHEN

        // TEHN
        XCTAssertEqual(vcCount, 2)
    }

    var firstTabRootVC: BaseViewController? {
        if let vc = sut.viewControllers?.first,
            let navVC = vc as? UINavigationController,
            let firtNavChildVC = navVC.viewControllers.first,
            let baseVC = firtNavChildVC as? BaseViewController {
            return baseVC
        }
        return nil
    }

    func test_FirstTabRootVC_IsBaseViewController() {
        // GIVEN
        let optionalVC = firstTabRootVC
        // WHEN

        // TEHN
        XCTAssertNotNil(optionalVC)
    }

    func test_FirtRootVcOnTabVC_hasNoLeftNavItem() {
        // GIVEN
        let vc = firstTabRootVC
        let hasLeftNavItem = vc?.navigationItem.leftBarButtonItem != nil
        // WHEN
        let _ = vc?.view
        // TEHN
        XCTAssertFalse(hasLeftNavItem)
    }

    func test_ModaledVc_hasCloseButton_asLeftNavItem() {
        // GIVEN
        let modaledVc = ModalViewController()
        // WHEN
        firstTabRootVC?.present(modaledVc, animated: false, completion: {
            // TEHN
            let modaledVcHasCloseButton = modaledVc.navigationItem.leftBarButtonItem != nil
            XCTAssertTrue(modaledVcHasCloseButton)
        })
    }

    func test_ModaledVC_CanDismiss_WhenCloseButtonTapped() {
        // GIVEN
        class MockNavigationController: UINavigationController {

            var popViewControllerIsCalled = false
            override func popViewController(animated: Bool) -> UIViewController? {
                popViewControllerIsCalled = true
                return UIViewController()
            }
        }
        let modaledVc = ModalViewController()
        let mockNavigationController = MockNavigationController(rootViewController: modaledVc)
        // WHEN
        firstTabRootVC?.present(mockNavigationController, animated: false, completion: { 
            if let backButton = modaledVc.navigationItem.leftBarButtonItem?.customView as? UIButton {
                backButton.sendActions(for: .touchUpInside)
            }else {
                XCTAssertTrue(false, "left navigation item has no button")
            }
            // THEN
            XCTAssertEqual(mockNavigationController.popViewControllerIsCalled, true)
        })
    }
}
