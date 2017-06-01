//
//  ArrayExtensions.swift
//  Pods
//
//  Created by frank on 2017. 5. 31..
//
//

import Foundation

public extension Array {
    public subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
