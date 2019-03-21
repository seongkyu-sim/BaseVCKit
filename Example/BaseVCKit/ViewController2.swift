//
//  ViewController2.swift
//  BaseVCKit
//
//  Created by frank on 2017. 4. 24..
//  Copyright © 2017년 CocoaPods. All rights reserved.
//

import UIKit
import BaseVCKit

class ViewController2: BaseViewController {

    private lazy var headerView: TableHeaderView = {
        let v = TableHeaderView()
        return v
    }()
    fileprivate let cellIdentifier = "cell"
    private lazy var tableView: UITableView = { [unowned self] in
        let v = UITableView()
        v.backgroundColor = UIColor.clear
        v.rowHeight = UITableView.automaticDimension
        v.estimatedRowHeight = 100
//        v.separatorStyle = .none
        v.dataSource = self
        v.delegate = self
        self.view.addSubview(v)
        v.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        v.contentInset.bottom = 60
        return v
        }()

    // MARK: - Init SubViews

    override func initSubViews() {
        super.initSubViews()
    }

    override func initSubViewConstraints() {
        super.initSubViewConstraints()

        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func didInitSubViewsConstraints() {
        super.didInitSubViewsConstraints()

        headerView.setHeaderView(onTableView: tableView)
    }

}


extension ViewController2: UITableViewDataSource {

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
        cell.textLabel?.text = "Row: \(indexPath.row)"
        return cell
    }
}

extension ViewController2: UITableViewDelegate {

}


//
extension ViewController2 {
    // MARK: - MemberInfoHeaderView

    class TableHeaderView: BaseTableHeaderFooterView {

        private lazy var nameLb: UILabel = {
            let v = UILabel.configureLabel(color: .black, size: 20)
            v.textAlignment = .center
            self.contentView.addSubview(v)
            return v
        }()
        private lazy var descLb: UILabel = {
            let v = UILabel.configureLabel(color: .lightGray, size: 13, weight: UIFont.Weight.medium)
            v.textAlignment = .center
            self.contentView.addSubview(v)
            return v
        }()

        override func commonInit() {
            super.commonInit()
            isEnableStickBgToTop = true
            backgroundColor = UIColor.yellow

            nameLb.text = "Name"
            descLb.text = "will be desc..."
        }


        // MARK: - Layout

        override func configureConstraints() {
            super.configureConstraints()

            let inset = UIEdgeInsets(top: 30, left: 14, bottom: 24, right: 14)

            nameLb.snp.makeConstraints { (make) in
                make.top.left.right.equalToSuperview().inset(inset)
            }
            descLb.snp.makeConstraints { (make) in
                make.top.equalTo(nameLb.snp.bottom).offset(6)
                make.left.bottom.right.equalToSuperview().inset(inset)
                make.left.right.equalToSuperview().inset(inset)
            }
        }
    }
}
