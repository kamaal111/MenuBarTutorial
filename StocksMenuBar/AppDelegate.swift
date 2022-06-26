//
//  AppDelegate.swift
//  StocksMenuBar
//
//  Created by Kamaal M Farah on 26/06/2022.
//

import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {

    private var statusItem: NSStatusItem!
    private var popover = AppDelegate.makePopover()

    func applicationDidFinishLaunching(_ notification: Notification) {
        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let statusButton = statusItem.button {
            statusButton.image = NSImage(
                systemSymbolName: "chart.line.uptrend.xyaxis.circle",
                accessibilityDescription: "Chart Line")
            statusButton.action = #selector(togglePopover)
        }

        self.statusItem = statusItem
    }

    @objc
    private func togglePopover(_ button: NSStatusBarButton) {
        NotificationCenter.default.post(name: .populateStocks, object: nil)

        if popover.isShown {
            popover.performClose(nil)
        } else {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }

    private static func makePopover() -> NSPopover {
        let popover = NSPopover()

        popover.contentSize = NSSize(width: Constants.UI.popoverSize.width, height: Constants.UI.popoverSize.height)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView())

        return popover
    }

}
