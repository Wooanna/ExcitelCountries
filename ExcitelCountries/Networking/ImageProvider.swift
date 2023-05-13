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
    
    func getImage(url: URL) -> AnyPublisher<UIImage?, Error> {
        let imageRequest = ImageRequest(method: .get, url: url)
        return client.publisher(request: imageRequest)
            .tryMap(ImageMapper.map)
            .eraseToAnyPublisher()
    }
}

struct ImageMapper {
    static func map(data: Data, response: HTTPURLResponse) throws -> UIImage? {
        return UIImage(data: data)
    }
}
