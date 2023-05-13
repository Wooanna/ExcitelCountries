//
//  CountryDetailsView.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 12.05.23.
//

import Foundation
import UIKit

class CountryDetailsView: NibLoadingView {
    
    @IBOutlet weak private var name: UILabel!
    @IBOutlet weak private var population: UILabel!
    @IBOutlet weak private var region: UILabel!
    @IBOutlet weak private var capital: UILabel!

    func setup(viewModel: CountryDetailsViewModel) {
        name.text = viewModel.country.name
        capital.text = viewModel.country.capitalName
        population.text = viewModel.country.presentablePopulation
        region.text = viewModel.country.presentableRegion
    }
}
