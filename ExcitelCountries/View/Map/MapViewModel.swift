//
//  CountryDetailsViewModel.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 12.05.23.
//

import Foundation
import CoreLocation

class MapViewModel {
    
    private let country: Country
    var coordinate: CLLocationCoordinate2D
    var countryDetailsViewModel: CountryDetailsViewModel
    
    init(country: Country) {
        self.country = country
        countryDetailsViewModel = CountryDetailsViewModel(country: country)
        coordinate = country.location?.coordinate ?? CLLocationCoordinate2D()
    }
}
