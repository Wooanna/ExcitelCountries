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
    
    func test_shows_noResult_image() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        sut.searchBar(sut.searchBar, textDidChange: "asdnjak")
        
        XCTAssertFalse(sut.noResults.isHidden)
    }
    
    func test_searches_after_minCountLetters() throws {
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        
        sut.searchBar(sut.searchBar, textDidChange: "as")
        sut.searchBar.text = "aa"
        let filteredCount = sut.viewModel?.filteredItems.count
        let allCount = sut.viewModel?.items.count

        XCTAssertEqual(filteredCount, allCount)
    }
    
    private func makeSUT() throws -> CountriesViewController {
        let countriesStoryboard = UIStoryboard(name: StoryboardName.countries.rawValue, bundle: Bundle(for: CountriesViewController.self))
        let navigation = countriesStoryboard.instantiateInitialViewController() as? UINavigationController
        let initialVC = navigation?.topViewController
        
        return try XCTUnwrap(initialVC as? CountriesViewController)
    }
}
