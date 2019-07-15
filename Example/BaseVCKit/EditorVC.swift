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
    private lazy var txtField: UITextField = { [unowned self] in
        let v = UITextField()
        v.backgroundColor = UIColor.lightGray
        self.view.addSubview(v)
        return v
        }()
    private lazy var keyboardBar: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        v.backgroundColor = UIColor.yellow
        self.view.addSubview(v)
        return v
    }()
    /*
    override var inputAccessoryView: UIView? {
        return keyboardBar
    }
    */

    // MARK: - Init SubViews

    override func initSubViews() {
        super.initSubViews()
    }

    override func initSubViewConstraints() {
        super.initSubViewConstraints()

        let padding = UIEdgeInsets(top: 20, left: 16, bottom: keyboardFollowOffsetB, right: 16)

        /*
        txtView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        */

        txtField.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.bottom).offset(padding.top)
            $0.left.right.equalToSuperview().inset(padding)
            $0.height.equalTo(50)
        }
        keyboardBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-keyboardFollowOffsetB)
            $0.height.equalTo(44)
        }
    }


    // KeyboardObserable

    private var keyboardFollowOffsetB: CGFloat {
        return bottomLayoutGuide.length
    }

    override var keyboardFollowView: UIView? {
        return keyboardBar
    }

    override var keyboardFollowOffsetForAppeared: CGFloat {
        return keyboardFollowOffsetB
    }

    override var keyboardFollowOffsetForDisappeared: CGFloat {
        return keyboardFollowOffsetB
    }

    override var shouldStartKeyboardAnimationObserve: Bool {
        return true
    }
}


