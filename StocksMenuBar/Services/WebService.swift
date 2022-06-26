//
//  WebService.swift
//  StocksMenuBar
//
//  Created by Kamaal M Farah on 26/06/2022.
//

import Foundation
import os.log

enum NetworkError: Error {
    case invalidResponse
}

class WebService {
    private let logger = Logster(label: "web_service")

    func getStocks(url: URL) async throws -> [Stock] {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else { throw NetworkError.invalidResponse }

        return try JSONDecoder().decode([Stock].self, from: data)
    }

}
