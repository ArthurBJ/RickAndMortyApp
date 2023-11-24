//
//  LocationsRepository.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 22.11.2023.
//

import Foundation

protocol LocationsRepository {
    func fetchLocations(urlLocations: String) async throws -> (info: Info, locations: [Location])
}
