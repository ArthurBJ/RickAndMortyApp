//
//  EpisodesRepository.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 23.11.2023.
//

import Foundation

protocol EpisodesRepository {
    func fetchEpisodes(urlEpisodes: String) async throws -> (info: Info, episodes: [Episode])
}

