//
//  Country.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 7.05.23.
//

import Foundation
import CoreLocation

struct Country: Codable {
    
    var capitalName: String?
    var code: String?
    var name: String?
    var population: Int
    var region: String?
    var subregion: String?
    private var flag: String?
    private var latLng: [Double]?
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        capitalName = try? container.decodeIfPresent(String.self, forKey: .capitalName)
        code = try? container.decodeIfPresent(String.self, forKey: .code)
        flag = try? container.decodeIfPresent(String.self, forKey: .flag)
        latLng = try? container.decodeIfPresent([Double].self, forKey: .latLng)
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        population = try (container.decodeIfPresent(Int.self, forKey: .population)) ?? 0
        region = try? container.decodeIfPresent(String.self, forKey: .region)
        subregion = try? container.decodeIfPresent(String.self, forKey: .subregion)
    }
}

extension Country {
    
    var pngFlagUrl: URL? {
        guard let flag, let flagUrl = URL(string: flag) else { return nil }
        var components = URLComponents()
        components.scheme = flagUrl.scheme
        components.host = flagUrl.host
        let path = "/w160/" + flagUrl.lastPathComponent.replacingOccurrences(of: "svg", with: "png")
        components.path = path
        return components.url
    }
    
    var location: CLLocation? {
        guard let coordinates = latLng, coordinates.count == 2 else { return nil }
        return CLLocation(latitude: coordinates[0], longitude: coordinates[1])
    }
    
    var presentableRegion: String {
        "\(region ?? ""), \(subregion ?? "")"
    }
    
    var presentablePopulation: String {
        "Population: \(population)"
    }
}
