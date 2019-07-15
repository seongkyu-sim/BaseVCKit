//
//  UITableViewExtensions.swift
//  BaseVCKit
//
//  Created by frank on 2015. 11. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

public extension UITableView {

    public func isLastRow(at indexPath: IndexPath) -> Bool {
        let lastSectionIndex:Int = self.numberOfSections-1
        let lastRowIndex:Int = self.numberOfRows(inSection: lastSectionIndex)-1
        return (indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex)
    }

    public func isSelectedCell(at indexPath: IndexPath) -> Bool {
        guard let selectedRows = self.indexPathsForSelectedRows else {
            return false
        }

        return selectedRows.contains(indexPath)
    }
}
