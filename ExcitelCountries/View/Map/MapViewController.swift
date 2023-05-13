//
//  CountryDetailsViewController.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 10.05.23.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var viewModel: MapViewModel?
    
    @IBOutlet weak private var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.register(CountryAnnotation.self, forAnnotationViewWithReuseIdentifier: Constants.CountryAnnotation.identifier)
        guard let viewModel else { return }
        mapView.setCenter(viewModel.coordinate, animated: true)
        let countryPin = MKPointAnnotation()
        countryPin.coordinate = viewModel.coordinate
        mapView.addAnnotation(countryPin)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation,
                let viewModel else { return nil }
        
        var countryAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.CountryAnnotation.identifier)
        let countryView = CountryDetailsView()
        countryView.setup(viewModel: viewModel.countryDetailsViewModel)
        countryAnnotation = CountryAnnotation(countryView: countryView, frame: CGRect(origin: CGPoint.zero, size: Constants.MapViewController.countryDetailsViewSize))
        countryAnnotation?.annotation = annotation
        return countryAnnotation
    }
}
