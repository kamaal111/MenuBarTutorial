//
//  Logster.swift
//  StocksMenuBar
//
//  Created by Kamaal M Farah on 26/06/2022.
//

import Foundation
import os.log

struct Logster {
    private let logger: Logger

    init(label: String) {
        self.logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: label)
    }

    func info(_ message: String) {
        logger.info("\(message)")
    }

    func error(_ message: String) {
        logger.error("\(message)")
    }
}
