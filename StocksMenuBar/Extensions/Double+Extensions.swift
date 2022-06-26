//
//  Double+Extensions.swift
//  StocksMenuBar
//
//  Created by Kamaal M Farah on 26/06/2022.
//

import Foundation

extension Double {
    var formatAsCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "N/A"
    }
}
