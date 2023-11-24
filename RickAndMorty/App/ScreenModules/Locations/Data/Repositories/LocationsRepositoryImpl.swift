//
//  LocationsRepositoryImpl.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 22.11.2023.
//

import Foundation

struct LocationsRepositoryImpl: LocationsRepository {
    
    private(set) var apiService: ApiClientService
    
    func fetchLocations(urlLocations: String) async throws -> (info: Info, locations: [Location]) {
        let url = URL(string: urlLocations)
        return try await apiService.request(url: url, type: ResultsLocationsDTO.self).toDomain()
    }
    
}
