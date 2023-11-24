//
//  CharacterDetailRepositoryImpl.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

struct CharacterDetailRepositoryImpl: CharacterDetailRepository {
    
    private(set) var apiService: ApiClientService
    
    func fetchCharacterDetail(urlDetail: String) async throws -> Character {
        let url = URL(string: urlDetail)
        let result = try await apiService.request(url: url, type: CharacterDTO.self)
        return result.toDomain()
    }
    
}
