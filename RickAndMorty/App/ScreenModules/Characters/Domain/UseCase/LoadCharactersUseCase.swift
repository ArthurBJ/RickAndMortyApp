//
//  LoadCharactersUseCase.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

protocol LoadCharactersUseCase {
    func execute() async -> Result<[Character], Error>
}

final class LoadCharactersUseCaseImpl: LoadCharactersUseCase {
    
    private let characterRepository: CharactersRepository
    private var url: String
    private var result: (info: Info, characters: [Character])?
    
    init(characterRepository: CharactersRepository, url: String) {
        self.characterRepository = characterRepository
        self.url = url
    }
    
    func execute() async -> Result<[Character], Error> {
        guard !url.isEmpty else { return .success([]) }
        do {
            let repositoryResult = try await characterRepository.fetchCharacters(urlList: url)
            url = repositoryResult.info.next ?? .empty
            return .success(repositoryResult.characters)
        } catch let error {
            return .failure(error)
        }
    }
    
}
