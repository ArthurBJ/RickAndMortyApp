//
//  ResultsLocationsDTO.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 22.11.2023.
//

import Foundation

struct ResultsLocationsDTO: Decodable {
    let info: InfoDTO
    let results: [LocationDTO]
}
