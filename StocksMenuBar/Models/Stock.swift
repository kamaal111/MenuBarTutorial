//
//  Stock.swift
//  StocksMenuBar
//
//  Created by Kamaal M Farah on 26/06/2022.
//

import Foundation

struct Stock: Decodable {
    let symbol: String
    let description: String
    let price: Double
}
