//
//  CountriesRequest.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 13.05.23.
//

import Foundation

class CountriesRequest: BaseRequest {

    override init(method: RestMethod, path: String, baseUrl: String = "https://excitel-countries.azurewebsites.net/") {
        super.init(method: method, path: path, baseUrl: baseUrl)
    }
}

