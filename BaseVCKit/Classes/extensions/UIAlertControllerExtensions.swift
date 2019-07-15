//
//  UIAlertControllerExtensions.swift
//  BaseVCKit
//
//  Created by frank on 2016. 5. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

public extension UIAlertController {
    static func showAlert(message: String?, title: String = "title.Notice".localized) {
        guard let topVC = UIApplication.topVC() else {
            print("!!! there r no topVC")
            return
        }

        let msg = message != nil ?  message : "No message"
        let actionSheetController: UIAlertController = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )
        let cancelAction: UIAlertAction = UIAlertAction(title: "btn.Confirm".localized, style: .cancel) {
            action  in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        topVC.present(actionSheetController, animated: true, completion: nil)
    }
}
