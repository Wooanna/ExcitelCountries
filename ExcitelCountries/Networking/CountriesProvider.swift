//
//  CountriesProvider.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 7.05.23.
//

import Foundation
import Combine

enum CountriesError: Error {
    case invalidUrl(message: String)
}

class CountriesProvider {
    
    let client: HTTPClient
    let baseUrl = "https://excitel-countries.azurewebsites.net/"
    let endPoint = "countries"
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getAllCountries() -> AnyPublisher<[Country], Error> {
        guard let url = URL(string: baseUrl + endPoint) else {
            return Fail(error: CountriesError.invalidUrl(message: "Invalid requestUrl")).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return client.publisher(request: request)
            .tryMap(CountryListMapper.map)
            .eraseToAnyPublisher()

    }
}

struct CountryListMapper {
    static func map(data: Data, response: HTTPURLResponse) throws -> [Country] {
        //TODO: catch/show error check response
        return try JSONDecoder().decode([Country].self, from: data)
    }
}

