//
//  ArrayExtensions.swift
//  BaseVCKit
//
//  Created by frank on 2017. 5. 31..
//  Copyright © 2016년 colavo. All rights reserved.
//

import Foundation

public extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
