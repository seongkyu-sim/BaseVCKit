//
//  BaseTableHeaderFooterView.swift
//  BaseVCKit
//
//  Created by frank on 2016. 5. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

open class BaseTableHeaderFooterView: UIView, SizeWithLayout {

    open var isEnableStickBgToTop: Bool = false
    open override var backgroundColor: UIColor? {
        didSet {
            bgView.backgroundColor = backgroundColor
        }
    }

    private lazy var bgView: UIView = {
        let v = UIView()
        self.insertSubview(v, belowSubview: self.contentView)
        return v
    }()
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

        if let superview = superview { removeObserversFromView(view: superview) }
        if let newSuperview = newSuperview { addScrollViewObservers(view: newSuperview) }
    }

    deinit {
        if let superview = superview { removeObserversFromView(view: superview) }
    }


    // MARK: - Init

    open func commonInit() {
        backgroundColor = UIColor.white
        configureConstraints()
    }


    // MARK: - Layout

    open func configureConstraints() {

        bgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.left.bottom.right.equalToSuperview()
        }
        contentView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
    }


    // MARK: - Public Mehtods

    open func setHeaderView(onTableView tableView: UITableView) {
        setHeaderFooter(isHeader: true, onTatbleView: tableView)
    }

    open func setFooterView(onTableView tableView: UITableView) {
        setHeaderFooter(isHeader: false, onTatbleView: tableView)
    }


    // MARK: - Helper

    private func setHeaderFooter(isHeader: Bool, onTatbleView tableView: UITableView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if isHeader {
            tableView.tableHeaderView = self
        }else {
            tableView.tableFooterView = self
        }

        let selfSize = self.size
        self.frame = CGRect(origin: CGPoint.zero, size: selfSize)

        if isHeader {
            tableView.tableHeaderView = self
        }else {
            tableView.tableFooterView = self
        }
        self.translatesAutoresizingMaskIntoConstraints = true
        self.frame.origin.x = 0
    }


    // MARK: - Stick Top

    fileprivate func stickBackgroundToTop() {
        guard let scrollView = self.superview as? UIScrollView else { return }

        let insetTop = scrollView.contentInset.top
        let offsetY = scrollView.contentOffset.y
        var offsetTop = offsetY + insetTop
        if offsetTop > 0 {
            offsetTop = 0
        }
        bgView.snp.updateConstraints { (make) in
            make.top.equalToSuperview().offset(offsetTop)
        }
    }
}

// KVO
extension BaseTableHeaderFooterView {

    fileprivate func removeObserversFromView(view: UIView) -> Void {
        guard isEnableStickBgToTop else { return }
        assert(nil != view as? UIScrollView, "Self's superview must be kind of `UIScrollView`")

        view.removeObserver(self, forKeyPath: KVOKeyHelper.scrollViewContentOffset)
    }

    fileprivate func addScrollViewObservers(view: UIView) -> Void {
        guard isEnableStickBgToTop else { return }
        assert(nil != view as? UIScrollView, "Self's superview must be kind of `UIScrollView`")

        view.addObserver(self, forKeyPath: KVOKeyHelper.scrollViewContentOffset, options: NSKeyValueObservingOptions.new, context: nil)
    }

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard isEnableStickBgToTop else { return }

        if keyPath == KVOKeyHelper.scrollViewContentOffset {
            guard let nsPoint = change?[NSKeyValueChangeKey.newKey], let _ = (nsPoint as AnyObject).cgPointValue else { return }
            stickBackgroundToTop()
        }
    }
}


enum KVOKeyHelper {
    static var scrollViewContentOffset: String {
        return NSStringFromSelector(#selector(getter: UIScrollView.contentOffset))
    }
    static var scrollViewContentSize: String {
        return NSStringFromSelector(#selector(getter: UIScrollView.contentSize))
    }
    static var scrollViewFrame: String {
        return NSStringFromSelector(#selector(getter: UIScrollView.frame))
    }
    static var scrollViewContentInset: String {
        return NSStringFromSelector(#selector(getter: UIScrollView.contentInset))
    }
}

