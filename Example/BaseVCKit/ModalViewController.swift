//
//  ModalViewController.swift
//  BaseVCKit
//
//  Created by frank on 2017. 4. 24..
//  Copyright © 2017년 CocoaPods. All rights reserved.
//

import UIKit
import BaseVCKit

class ModalViewController: BaseViewController {

    private lazy var txtField: UITextField = {
        let v = UITextField()
        v.backgroundColor = UIColor.lightGray
        self.view.addSubview(v)
        return v
    }()
    fileprivate lazy var modalBtn: UIButton = { [unowned self] in
        let v = UIButton()
        v.setTitle("Modal", for: .normal)
        v.backgroundColor = .lightGray
        v.setTitle("clicked", for: .highlighted)
        v.addTarget(self, action: #selector(self.modal), for: .touchUpInside)
        self.view.addSubview(v)
        return v
        }()
    fileprivate lazy var doneBtn: UIButton = { [unowned self] in
        let v = UIButton()
        v.setTitle("Done", for: .normal)
        v.backgroundColor = .lightGray
        v.addTarget(self, action: #selector(self.done), for: .touchUpInside)
        self.view.addSubview(v)
        return v
        }()


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Modal"
        layoutSubViews()
    }


    // MARK: - Layout

    private func layoutSubViews() {
        let padding = UIEdgeInsets(
            top: 100,
            left: 20,
            bottom: keyboardFollowDisAppearOffsetB,
            right: 20
        )

        print("padding: \(padding)")

        txtField.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(padding)
            $0.height.equalTo(40)
        }

        modalBtn.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(padding)
            $0.height.equalTo(70)
            $0.centerY.equalToSuperview()
        }

        doneBtn.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(padding)
//            $0.bottom.equalToSuperview().offset(-keyboardFollowOffsetB)
            $0.bottom.equalToSuperview().inset(padding)
        }
    }


    // MARK: - Actions

    @objc private func done(sender:UIButton!) {
        view.endEditing(true)
    }

    @objc private func modal(sender:UIButton!) {
        modal(ModalViewController())
    }


    // KeyboardObserable

    private let keyboardFollowAppearOffsetB = CGFloat(16)
    private var keyboardFollowDisAppearOffsetB: CGFloat {
//        return bottomLayoutGuide.length
        return 34
    }

    override var keyboardFollowView: UIView? {
        return doneBtn
    }

    override var keyboardFollowOffsetForAppeared: CGFloat {
        return keyboardFollowAppearOffsetB
    }

    override var keyboardFollowOffsetForDisappeared: CGFloat {
//        return keyboardFollowOffsetB
        return keyboardFollowDisAppearOffsetB
    }
}
