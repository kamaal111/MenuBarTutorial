//
//  ContentView.swift
//  StocksMenuBar
//
//  Created by Kamaal M Farah on 26/06/2022.
//

import SwiftUI
import SalmonUI

struct ContentView: View {
    @StateObject private var stockListViewModel = StockListViewModel()

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Stocks")
                    .font(.title2)
                    .bold()
                    .padding()
                List(stockListViewModel.stocks, id: \.symbol) { stock in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(stock.symbol)
                                .fontWeight(.semibold)
                            Text(stock.description)
                                .opacity(0.4)
                            Divider()
                        }
                        Spacer()
                        Text(stock.price.formatAsCurrency)
                    }
                }
            }
            if stockListViewModel.loading {
                KActivityIndicator(isAnimating: .constant(true), style: .spinning)
            }
        }
        .frame(width: Constants.UI.popoverSize.width, height: Constants.UI.popoverSize.height)
        .onAppear(perform: {
            if stockListViewModel.stocks.isEmpty {
                Task {
                    await stockListViewModel.populateStocks()
                }
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
