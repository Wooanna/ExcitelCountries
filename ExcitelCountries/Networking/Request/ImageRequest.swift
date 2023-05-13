//
//  ImageRequest.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 13.05.23.
//

import Foundation

class ImageRequest: BaseRequest {
    
    override init(method: RestMethod, path: String, baseUrl: String) {
        super.init(method: method, path: path, baseUrl: baseUrl)
    }
    
    init(method: RestMethod, url: URL) {
        super.init(method: method, path: "", baseUrl: "")
        self.url = url
    }
}
