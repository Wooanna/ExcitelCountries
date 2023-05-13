//
//  CountryAnnotation.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 12.05.23.
//

import Foundation
import MapKit

class CountryAnnotation: MKAnnotationView {
    
    convenience init(countryView: CountryDetailsView, frame: CGRect) {
        self.init(frame: frame)
        countryView.frame = bounds
        layer.cornerRadius = Constants.CountryAnnotation.cornerRadius
        clipsToBounds = true
        addSubview(countryView)        
    }
}
