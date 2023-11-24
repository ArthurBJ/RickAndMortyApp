//
//  EpisodesRepositoryImpl.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 23.11.2023.
//

import Foundation

struct EpisodesRepositoryImpl: EpisodesRepository {
    
    private(set) var apiClient: ApiClientService
    
    func fetchEpisodes(urlEpisodes: String) async throws -> (info: Info, episodes: [Episode]) {
        let url = URL(string: urlEpisodes)
        return try await apiClient.request(url: url, type: ResultEpisodesDTO.self).toDomain()
    }
    
}
