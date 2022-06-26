//
//  NotificationName+extensions.swift
//  StocksMenuBar
//
//  Created by Kamaal M Farah on 26/06/2022.
//

import Foundation

extension Notification.Name {
    static let populateStocks = makeName(withKey: "populate_stocks")

    private static func makeName(withKey key: String) -> Notification.Name {
        Notification.Name("\(Bundle.main.bundleIdentifier!).notification.\(key)")
    }
}
