//
//  CharactersRepository.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

protocol CharactersRepository {
    func fetchCharacters(urlList: String) async throws -> (info: Info, characters: [Character])
}
