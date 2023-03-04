//
//  Double+Ext.swift
//  FreshFinder
//
//  Created by Guillermo Santos Barrios on 3/3/23.
//

import Foundation

extension Double {
    func toCurrencyString() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let priceString = currencyFormatter.string(from: NSNumber(value: self))!
        return priceString
    }
}
