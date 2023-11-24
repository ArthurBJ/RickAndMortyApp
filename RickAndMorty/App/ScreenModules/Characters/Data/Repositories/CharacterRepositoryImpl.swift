//
//  CharacterRepositoryImpl.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

struct CharacterRepositoryImpl: CharactersRepository {
    
    let apiClient: ApiClientService
    
    func fetchCharacters(urlList: String) async throws -> (info: Info, characters: [Character]) {
        let url =  URL(string: urlList)
        return try await apiClient.request(url: url, type: ResultsCharactersDTO.self).toDomain()
    }
    
}
