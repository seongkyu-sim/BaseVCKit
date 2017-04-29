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
        let marginH: CGFloat = 20

        txtField.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.equalTo(marginH)
            make.right.equalTo(-marginH)
            make.height.equalTo(40)
        }

        modalBtn.snp.makeConstraints { (make) in
            make.left.equalTo(marginH)
            make.right.equalTo(-marginH)
            make.height.equalTo(70)
            make.centerY.equalToSuperview()
        }

        doneBtn.snp.makeConstraints { (make) in
            make.left.equalTo(marginH)
            make.right.equalTo(-marginH)
            make.bottom.equalToSuperview().offset(-keyboardFollowOffset)
        }
    }


    // MARK: - Actions

    @objc private func done(sender:UIButton!) {
        view.endEditing(true)
    }

    @objc private func modal(sender:UIButton!) {
        modal(ModalViewController())
    }
}

// KeyboardObserable
extension ModalViewController: KeyboardSanpable {

    public var keyboardFollowView: UIView? {
        return doneBtn
    }
    public var keyboardFollowOffset: CGFloat {
        return 16
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        startKeyboardAnimationObserveWithViewWillAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        stopKeyboardAnimationObserveWithViewWillDisAppear()
    }
}
