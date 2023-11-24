//
//  ResultsCharactersDTO.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

struct ResultsCharactersDTO: Decodable {
    let results: [CharacterDTO]
    let info: InfoDTO
}

