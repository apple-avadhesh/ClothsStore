//
//  CurrencyHelper.swift
//  ClothsStore
//
//  Created by Zoombie on 09/04/22.
//

import Foundation

class CurrencyHelper {

    class func getMoneyString(_ value: Float) -> String {
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        return currencyFormatter.string(from: NSNumber(value: value)) ?? "0"
    }
}
