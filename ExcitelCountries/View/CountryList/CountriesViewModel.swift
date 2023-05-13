//
//  CountriesViewModel.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 7.05.23.
//

import Foundation
import Combine

class CountriesViewModel {
    
    var countriesService: CountriesProvider
    let itemsUpdate = PassthroughSubject<Void, Never>()
    var filteredItems: [Country] = []
    
    private (set) var items: [Country] = []
    private var subscribers = Set<AnyCancellable>()
    
    init(countriesService: CountriesProvider) {
        self.countriesService = countriesService
        bindCountriesService()
    }
    
    private func bindCountriesService() {
        countriesService.getAllCountries()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                //TODO: handle error, show user no internet error, generic error etc.
            }, receiveValue: { [weak self] countries in
                guard let self = self else { return }
                self.items = countries.sorted(by: { $0.population > $1.population })
                self.filteredItems = self.items
                self.itemsUpdate.send()
            })
            .store(in: &subscribers)
    }
    
    func resetItems() {
        filteredItems = items
        itemsUpdate.send()
    }
}
