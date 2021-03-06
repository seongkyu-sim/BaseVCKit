//
//  ViewController.swift
//  BaseVCKit
//
//  Created by seongkyu-sim on 04/19/2017.
//  Copyright (c) 2017 seongkyu-sim. All rights reserved.
//

import UIKit
import BaseVCKit

class ViewController: BaseViewController {

    private lazy var lb: UILabel = {
        let v = UILabel.configureLabel(color: UIColor.green, size: 18)
        v.textAlignment = .center
        v.text = "Strike through test"
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
    fileprivate lazy var pushBtn: UIButton = { [unowned self] in
        let v = UIButton()
        v.setTitle("Push", for: .normal)
        v.backgroundColor = .lightGray
        v.setTitle("clicked", for: .highlighted)
        v.addTarget(self, action: #selector(self.push), for: .touchUpInside)
        self.view.addSubview(v)
        return v
        }()
    fileprivate let doneBtnBottomOffset: CGFloat = 12

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "title"

        lb.renderStrikethrough(text: "Strike through test", color: UIColor.red)


        configureBackOrCloseOnNavBar()
        layoutSubViews()
    }


    // MARK: - Layout

    private func layoutSubViews() {
        let inset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        lb.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(inset)
        }
        modalBtn.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(inset)
            make.height.equalTo(70)
            make.centerY.equalToSuperview()
        }
        pushBtn.snp.makeConstraints { (make) in
            make.top.equalTo(modalBtn.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(inset)
            make.height.equalTo(70)
        }
    }


    // MARK: - Actions

    @objc private func modal(sender:UIButton!) {
        modal(ModalViewController())
    }

    @objc private func push(sender:UIButton!) {
//        push(ModalViewController())
        let vc = EditorVC()
        vc.hidesBottomBarWhenPushed = true
        push(vc)
    }
}





