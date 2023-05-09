//
//  ImageProvider.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 8.05.23.
//

import Foundation
import Combine
import UIKit

class ImageProvider {
    let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func getImage(forUrl url: URL) -> AnyPublisher<UIImage?, Error> {
        client.publisher(request: URLRequest(url: url))
            .tryMap(ImageMapper.map)
            .eraseToAnyPublisher()
    }
}

struct ImageMapper {
    static func map(data: Data, response: HTTPURLResponse) throws -> UIImage? {
        //TODO: catch/show error check response

        return UIImage(data: data)
    }
}
