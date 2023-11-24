//
//  ResultEpisodesDTO + Mapper.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 23.11.2023.
//

import Foundation

extension ResultEpisodesDTO {
    func toDomain() -> (info: Info, episodes: [Episode]) {
        let info = Info(next: info.next)
        let episodes = results.map {
            Episode(id: $0.id, name: $0.name, airDate: $0.airDate, episode: $0.episode)
        }
        
        return (info: info, episodes: episodes)
    }
}
