//
//  ExcitelCountriesTests.swift
//  ExcitelCountriesTests
//
//  Created by Yoana Mareva on 7.05.23.
//

import XCTest
@testable import ExcitelCountries

final class ExcitelCountriesTests: XCTestCase {
    
    func test_canInit() throws {
        let countriesStoryboard = UIStoryboard(name: "Countries", bundle: Bundle(for: CountriesViewController.self))
        let initialVC = countriesStoryboard.instantiateInitialViewController()
        
        _ = try XCTUnwrap(initialVC as? CountriesViewController)
    }
}
