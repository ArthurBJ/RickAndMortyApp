//
//  LoadEpisodesUseCase.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 23.11.2023.
//

import Foundation

protocol LoadEpisodesUseCase {
    mutating func getEpisodes() async -> Result<[Episode], Error>
}

struct LoadEpisodesUseCaseImpl: LoadEpisodesUseCase {
    
    private(set) var episodeRepository: EpisodesRepository
    private(set) var urlEpisodes: String
    
    mutating func getEpisodes() async -> Result<[Episode], Error> {
        guard !urlEpisodes.isEmpty else { return .success([])}
        
        do {
            let result = try await episodeRepository.fetchEpisodes(urlEpisodes: urlEpisodes)
            urlEpisodes = result.info.next ?? .empty
            return .success(result.episodes)
        } catch {
            return .failure(error)
        }
    }
    
}
