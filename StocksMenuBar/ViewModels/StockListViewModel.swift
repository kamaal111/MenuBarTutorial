//
//  StockListViewModel.swift
//  StocksMenuBar
//
//  Created by Kamaal M Farah on 26/06/2022.
//

import Foundation
import os.log

final class StockListViewModel: ObservableObject {

    @Published private(set) var stocks: [Stock] = []
    @Published var loading = false

    private let logger = Logster(label: "stock_list_view_model")

    init() {
        setupObservers()
    }

    deinit {
        removeObservers()
    }

    func populateStocks() async {
        logger.info("populating stocks")
        await setLoading(true)

        let stocks: [Stock]
        do {
            stocks = try await WebService().getStocks(url: Constants.URLS.latestStocks)
        } catch {
            await setLoading(false)
            logger.error("error while getting stocks; \(error)")
            return
        }

        await setStocks(stocks)
        await setLoading(false)
    }

    @MainActor
    private func setStocks(_ stocks: [Stock]) {
        logger.info("populated stocks")
        self.stocks = stocks
    }

    @MainActor
    private func setLoading(_ state: Bool) {
        self.loading = state
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(populateStocksObserver),
            name: .populateStocks,
            object: nil)
    }

    private func removeObservers() {
        let notifications: [NSNotification.Name] = [.populateStocks]
        notifications.forEach {
            NotificationCenter.default.removeObserver(self, name: $0, object: nil)
        }
    }

    @objc
    private func populateStocksObserver(_ notification: Notification) {
        Task {
            await populateStocks()
        }
    }

}
