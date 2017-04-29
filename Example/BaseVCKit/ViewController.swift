//
//  ViewController.swift
//  BaseVCKit
//
//  Created by seongkyu-sim on 04/19/2017.
//  Copyright (c) 2017 seongkyu-sim. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

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

        layoutSubViews()
    }


    // MARK: - Layout

    private func layoutSubViews() {
        let marginH: CGFloat = 20

        doneBtn.snp.makeConstraints { (make) in
            make.left.equalTo(marginH)
            make.right.equalTo(-marginH)
            make.height.equalTo(70)
            make.centerY.equalToSuperview()
        }
    }


    // MARK: - Actions

    @objc private func done(sender:UIButton!) {
        modal(ModalViewController())
    }
}



