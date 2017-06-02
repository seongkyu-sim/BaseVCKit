//
//  BaseTableHeaderFooterView.swift
//  BaseVCKit
//
//  Created by frank on 2016. 5. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

open class BaseTableHeaderFooterView: UIView {

    open lazy var contentView: UIView = { [unowned self] in
        let v = UIView()
        self.addSubview(v)
        return v
        }()

    public override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)

        self.commonInit()
    }

    public required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)

        self.commonInit()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        self.frame.size = contentView.frame.size
    }

    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        setNeedsLayout()
        layoutIfNeeded()
    }

    open func commonInit() {
        backgroundColor = UIColor.white
        configureConstraints()
    }


    // MARK: - Layout

    open func configureConstraints() {
        contentView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
    }
}
