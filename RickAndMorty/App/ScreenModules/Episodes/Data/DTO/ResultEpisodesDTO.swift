//
//  ResultEpisodesDTO.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 23.11.2023.
//

import Foundation

struct ResultEpisodesDTO: Decodable {
    let info: InfoDTO
    let results: [EpisodeDTO]
}
