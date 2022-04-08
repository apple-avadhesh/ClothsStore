//
//  NumberFormatter.swift
//  ClothsStore
//
//  Created by Zoombie on 06/04/22.
//

import Foundation

extension Double {
    func currencyString() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedAmount = formatter.string(from: self as NSNumber) {
            return formattedAmount
        }
        return "0"
    }
}
