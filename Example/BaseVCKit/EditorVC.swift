//
//  EditorVC.swift
//  BaseVCKit_Example
//
//  Created by frank on 2018. 4. 17..
//  Copyright © 2018년 CocoaPods. All rights reserved.
//

import UIKit
import BaseVCKit

class EditorVC: BaseViewController {

    private lazy var txtView: UITextView = {
        let v = UITextView()
        v.keyboardDismissMode = .interactive
        v.contentInset.bottom = 1200
        self.view.addSubview(v)
        return v
    }()
    private lazy var keyboardBar: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
//        let v = UIView()
        v.backgroundColor = UIColor.yellow
//        self.view.insertSubview(v, aboveSubview: txtView)
        return v
    }()

    override var inputAccessoryView: UIView? {
        return keyboardBar
    }

    // MARK: - Init SubViews

    override func initSubViews() {
        super.initSubViews()
    }

    override func initSubViewConstraints() {
        super.initSubViewConstraints()

        txtView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        /*
        keyboardBar.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-keyboardFollowOffsetB)
            make.height.equalTo(44)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        */
    }


    // KeyboardObserable
    /*
    private let keyboardFollowOffsetB = CGFloat(0)

    override var keyboardFollowView: UIView? {
        return keyboardBar
    }

    override var keyboardFollowOffsetForAppeared: CGFloat {
        return keyboardFollowOffsetB
    }

    override var keyboardFollowOffsetForDisappeared: CGFloat {
        return keyboardFollowOffsetB
    }
    */

    override var shouldStartKeyboardAnimationObserve: Bool {
        return true
    }



    


}


