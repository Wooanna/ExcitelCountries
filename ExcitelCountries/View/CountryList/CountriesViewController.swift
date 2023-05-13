//
//  ViewController.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 7.05.23.
//

import UIKit
import Combine

class CountriesViewController: UIViewController {

    var viewModel: CountriesViewModel?
    var subscribers = Set<AnyCancellable>()
    
    @IBOutlet weak private var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak internal var tableView: UITableView!
    @IBOutlet weak internal var noResults: UIImageView!
    @IBOutlet weak internal var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CountriesViewModel(countriesService: CountriesProvider(client: URLSession.shared))
        tableView.keyboardDismissMode = .onDrag
        bindViewModel()
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.filteredItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell
        guard let country = viewModel?.filteredItems[indexPath.row] else { return UITableViewCell() }
        let cellViewModel = CountryTableViewCellViewModel(withCountry: country)
        cell?.viewModel = cellViewModel
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let mapViewController = UIStoryboard(name: StoryboardName.map.rawValue, bundle: Bundle.main).instantiateInitialViewController() as? MapViewController else { return }
        guard let country = viewModel?.filteredItems[indexPath.row] else { return }
        mapViewController.viewModel = MapViewModel(country: country)
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}

extension CountriesViewController {
    func bindViewModel() {
        viewModel?.itemsUpdate
        .sink(receiveValue: { [weak self] countries in
            guard let self else { return }
            self.tableView.reloadData()
            self.loadingIndicator.stopAnimating()
        }).store(in: &subscribers)
    }
}

extension CountriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            viewModel?.resetItems()
        }
        
        guard searchText.count >= Constants.CountryViewController.minSearchTextCount,
                let items = viewModel?.items else { return }
        
        viewModel?.filteredItems = items.filter { (item: Country) -> Bool in
            return item.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        noResults.isHidden = viewModel?.filteredItems.count ?? 0 > 0 ? true : false
        tableView.reloadData()
    }
}

