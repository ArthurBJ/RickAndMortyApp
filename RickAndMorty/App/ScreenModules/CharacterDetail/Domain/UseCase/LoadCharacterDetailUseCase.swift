//
//  LoadCharacterDetailUseCase.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

protocol LoadCharacterDetailUseCase {
    func execute() async throws -> Character
}

struct LoadCharacterDetailUseCaseImpl: LoadCharacterDetailUseCase {
    
    private(set) var characterDetailRepository: CharacterDetailRepository
    private(set) var urlDetail: String
    
    func execute() async throws -> Character {
        try await characterDetailRepository.fetchCharacterDetail(urlDetail: urlDetail)
    }
    
}
