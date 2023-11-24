//
//  ResultsLocationsDTO + Mapper.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 22.11.2023.
//

import Foundation

extension ResultsLocationsDTO {
    func toDomain() -> (info: Info, locations: [Location]) {
        let info = Info(next: info.next)
        let locations = results.map {
            Location(name: $0.name, type: $0.type, dimension: $0.dimension, url: $0.url)
        }
        
        return (info: info, locations: locations)
    }
}
