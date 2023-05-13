//
//  BaseRequest.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 13.05.23.
//

import Foundation

public enum RestMethod: String {
    case get
    case post
    case delete
    case put
    case patch
}

protocol Request {
    var method: RestMethod { get }
    var path: String { get }
    func toUrlRequest() -> URLRequest?
}

class BaseRequest: Request {

    var method: RestMethod
    var path: String = ""
    var baseUrl: String = ""
    var url: URL?
    
    init(method: RestMethod, path: String, baseUrl: String) {
        self.method = method
        self.path = path
        self.baseUrl = baseUrl
    }
    
    func toUrlRequest() -> URLRequest? {
        var urlRequest: URLRequest?
        if let url {
            urlRequest = URLRequest(url: url)
        } else {
            guard let url = URL(string: baseUrl + path) else {
                return nil
            }
            urlRequest = URLRequest(url: url)
        }
  
        switch method {
        case .get:
            urlRequest?.httpMethod = "GET"
        case .post:
            urlRequest?.httpMethod = "POST"
        case .delete:
            urlRequest?.httpMethod = "DELETE"
        case .put:
            urlRequest?.httpMethod = "PUT"
        case .patch:
            urlRequest?.httpMethod = "PATCH"
        }
        return urlRequest
    }
    
}

