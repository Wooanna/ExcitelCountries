//
//  Constants.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 12.05.23.
//

import Foundation

enum StoryboardName: String {
    case map = "Map"
    case countries = "Countries"
}

struct Constants {
    struct MapViewController {
        public static let countryDetailsViewSize = CGSize(width: 250, height: 100)
    }
    
    struct CountryAnnotation {
        public static let identifier = "CountryAnnotation"
        public static let cornerRadius: CGFloat = 10
        
    }
    
    struct CountryViewController {
        public static let minSearchTextCount = 3
    }
}
