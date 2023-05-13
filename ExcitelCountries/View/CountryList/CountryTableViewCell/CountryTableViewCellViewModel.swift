//
//  CountryTableViewCellViewModel.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 8.05.23.
//

import Foundation
import UIKit
import Combine

class CountryTableViewCellViewModel {
    
    var capital: String?
    var population: Int
    var subscribers = Set<AnyCancellable>()
    let imageDidLoad = PassthroughSubject<UIImage, Never>()
    var name: String?
    
    private var country: Country?
    
    init(withCountry country: Country) {
        
        self.country = country
        self.capital = country.capitalName
        self.population = country.population
        self.name = country.name
        
        guard let url = country.pngFlagUrl else { return }
        
        ImageProvider(client: URLSession.shared).getImage(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
             
            }, receiveValue: { [weak self] image in
                guard let self,
                      let image else { return }
                self.imageDidLoad.send(image)
            }).store(in: &subscribers)
    }
}
