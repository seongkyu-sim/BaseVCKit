//
//  DoubleExtensions.swift
//  Pods
//
//  Created by frank on 2017. 5. 31..
//
//

import Foundation

public extension Double {

    public func currency(withLocaleIdentifier localeIdentifier: String) -> String {

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: localeIdentifier)
        if localeIdentifier == "ko_KR" && NSLocale.current.languageCode == "ko" {
            formatter.currencySymbol = ""
            return formatter.string(for: self)! + "원"
        }
        return formatter.string(for: self)!
    }

    public func placeCeil(place: Int) -> Double {
        let tenCount = String(Int(self)).characters.count - place
        var adjustFate: Double = 1
        if tenCount > 0 {
            var k = 0
            repeat {
                adjustFate = adjustFate * 10
                k = k + 1
            } while k < tenCount
        }
        let ceilV = ceil(self/adjustFate) * adjustFate
        return ceilV
    }

    public var asPercentage:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        if let percentString = formatter.string(for: self) {
            return percentString
        }
        return "%"
    }
}
