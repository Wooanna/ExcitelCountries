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
       _ = try makeSUT()
    }
    
    func test_tableView_configured() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    private func makeSUT() throws -> CountriesViewController {
        let countriesStoryboard = UIStoryboard(name: "Countries", bundle: Bundle(for: CountriesViewController.self))
        let initialVC = countriesStoryboard.instantiateInitialViewController()
        
        return try XCTUnwrap(initialVC as? CountriesViewController)
    }
}
