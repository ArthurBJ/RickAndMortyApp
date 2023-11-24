//
//  EpisodeDTO.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 23.11.2023.
//

import Foundation

struct EpisodeDTO: Decodable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
}
