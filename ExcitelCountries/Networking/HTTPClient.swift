//
//  HTTPClient.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 7.05.23.
//

import Foundation
import Combine

protocol HTTPClient {
    func publisher(request: Request) -> AnyPublisher<(Data, HTTPURLResponse), Error>
}

extension URLSession: HTTPClient {
    
    struct InvalidHTTPResponseError: Error {}
    
    func publisher(request: Request) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        
        guard let urlRequest = request.toUrlRequest() else {
            return Fail(error: CountriesError.invalidUrl(message: "Invalid requestUrl")).eraseToAnyPublisher()
        }
        
        return dataTaskPublisher(for: urlRequest)
            .tryMap({ result in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw InvalidHTTPResponseError()
                }
                return (result.data, httpResponse)
            })
            .eraseToAnyPublisher()
    }
}
