//
//  ViewController.swift
//  BaseVCKit
//
//  Created by seongkyu-sim on 04/19/2017.
//  Copyright (c) 2017 seongkyu-sim. All rights reserved.
//

import UIKit
import BaseVCKit

class ViewController: UIViewController, NavButtonConfigurable {

    private lazy var txtField: UITextField = {
        let v = UITextField()
        v.backgroundColor = UIColor.lightGray
        self.view.addSubview(v)
        return v
        }()
    fileprivate lazy var doneBtn: UIButton = { [unowned self] in
        let v = UIButton()
        v.setTitle("Done", for: .normal)
        v.backgroundColor = .lightGray
        v.setTitle("clicked", for: .highlighted)
        v.addTarget(self, action: #selector(self.done), for: .touchUpInside)

        self.view.addSubview(v)
        return v
        }()
    fileprivate let doneBtnBottomOffset: CGFloat = 12

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        print("viewDidLoad, presentStatus.rawValue: \(presentStatus.rawValue)")

        layoutSubViews()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        print("viewDidAppear, presentStatus.rawValue: \(presentStatus.rawValue)")


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

        doneBtn.snp.makeConstraints { (make) in
            make.left.equalTo(marginH)
            make.right.equalTo(-marginH)
            make.bottom.equalToSuperview().offset(-doneBtnBottomOffset)
        }
    }


    // MARK: - Actions

    @objc private func done(sender:UIButton!) {
        view.endEditing(true)
    }
}


extension ViewController: KeyboardSanpable {
    var keyboardFollowView: UIView? {
        return doneBtn
    }
    var keyboardFollowOffset: CGFloat {
        return doneBtnBottomOffset
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        addKeyboardAnimationObserver()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        removeKeyboardAnimationObserver()
    }
}

