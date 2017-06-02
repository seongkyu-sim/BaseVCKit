//
//  BaseTableHeaderFooterView.swift
//  BaseVCKit
//
//  Created by frank on 2016. 5. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

class BaseTableHeaderFooterView: UIView {

    lazy var contentView: UIView = { [unowned self] in
        let v = UIView()
        self.addSubview(v)
        return v
        }()

    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)

        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)

        self.commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.frame.size = contentView.frame.size
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        setNeedsLayout()
        layoutIfNeeded()
    }

    internal func commonInit() {
        backgroundColor = UIColor.white
        configureConstraints()
    }


    // MARK: - Layout

    internal func configureConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
    }
}
