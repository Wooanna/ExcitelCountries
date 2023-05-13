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
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getAllCountries() -> AnyPublisher<[Country], Error> {
        let countriesRequest = CountriesRequest(method: .get, path: "countries")
        return client.publisher(request: countriesRequest)
            .tryMap(CountryListMapper.map)
            .eraseToAnyPublisher()
    }
}

struct CountryListMapper {
    static func map(data: Data, response: HTTPURLResponse) throws -> [Country] {
        return try JSONDecoder().decode([Country].self, from: data)
    }
}

