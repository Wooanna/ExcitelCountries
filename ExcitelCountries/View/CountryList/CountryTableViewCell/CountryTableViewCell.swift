//
//  CountryTableViewCell.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 8.05.23.
//

import Foundation
import UIKit
import Combine

class CountryTableViewCell: UITableViewCell {
    
    static let identifier = "CountryTableViewCell"
    
    @IBOutlet weak private var population: UILabel!
    @IBOutlet weak private var countryName: UILabel!
    @IBOutlet weak private var flagImage: UIImageView!
    
    var subscribers = Set<AnyCancellable>()
    
    var viewModel: CountryTableViewCellViewModel? {
        didSet {
            population.text = "\(viewModel?.population ?? 0)"
            countryName.text = viewModel?.name
            
            viewModel?.imageDidLoad
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] image in
                    guard let self else { return }
                    self.flagImage?.image = image
                }).store(in: &subscribers)
        }
    }
}
