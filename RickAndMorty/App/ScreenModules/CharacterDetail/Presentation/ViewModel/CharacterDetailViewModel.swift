//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation
import Combine

protocol CharacterDetailViewModel: BaseViewModel {
    var nameCharacter: String { get }
    var status: String { get }
    var specie: String { get }
    var imageData: Data? { get }
    var origin: String { get }
    var location: String { get }
}

final class CharacterDetailViewModelImpl: CharacterDetailViewModel {
    
    var state: PassthroughSubject<StateController, Never>
    
    var nameCharacter: String {
        character?.name ?? .empty
    }
    
    var status: String {
        character?.status?.description ?? .empty
    }
    
    var specie: String {
        character?.specie.description ?? .empty
    }
    
    var imageData: Data? {
        dataImageUseCase.getDataFromCache(url: character?.urlImage ?? .empty)
    }
    
    var origin: String {
        character?.origin.name ?? .empty
    }
    
    var location: String {
        character?.loaction.name ?? .empty
    }
    
    private let loadCharacterDetailUseCase: LoadCharacterDetailUseCase
    private let dataImageUseCase: ImageDataUseCase
    private var character: Character?
    
    init(state: PassthroughSubject<StateController, Never>, loadCharacterDetailUseCase: LoadCharacterDetailUseCase, dataImageUseCase: ImageDataUseCase) {
        self.state = state
        self.loadCharacterDetailUseCase = loadCharacterDetailUseCase
        self.dataImageUseCase = dataImageUseCase
    }
    
    
    func viewDidLoad() {
        state.send(.loading)
        Task {
            do {
                let result = try await loadCharacterDetailUseCase.execute()
                character = result
                state.send(.success)
            } catch {
                state.send(.fail(error: error.localizedDescription))
            }
        }
    }
    
    
}
