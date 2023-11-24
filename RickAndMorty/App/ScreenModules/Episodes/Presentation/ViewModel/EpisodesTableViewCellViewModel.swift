//
//  EpisodesTableViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 23.11.2023.
//

import Foundation

struct EpisodesTableViewCellViewModel {
    
    private(set) var episode: Episode
    
    var numberEpisode: String {
        return "# \(episode.id)"
    }
    
    var name: String {
        return episode.name
    }
    
    var date: String {
        return episode.airDate
    }
    
    var seasonAndEpisode: String {
        return episode.episode
    }
}
