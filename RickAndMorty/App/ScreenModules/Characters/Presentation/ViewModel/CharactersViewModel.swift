//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Combine

protocol CharactersViewModel: BaseViewModel {
    var itemCharactersCount: Int { get }
    var lastPage: Bool { get }
    func getItemMenuViewModel(row: Int) -> CharacterTableViewCellViewModel
    func getUrlDetail(row: Int) -> String
}

final class CharactersViewModelImpl: CharactersViewModel {
    
    var state: PassthroughSubject<StateController, Never>
    
    var itemCharactersCount: Int {
        return characters.count
    }
    
    var lastPage: Bool {
        lastPageValidationUseCase.lastPage
    }
    
    private var characters: [Character] = []
    private let loadCharacterUseCase: LoadCharactersUseCase
    private var lastPageValidationUseCase: LastPageValidationUseCase
    private var imageDataUseCase: ImageDataUseCase
    
    init(loadCharacterUseCase: LoadCharactersUseCase, state: PassthroughSubject<StateController, Never>, lastPageValidationUseCase: LastPageValidationUseCase, imageDataUseCase: ImageDataUseCase) {
        self.state = state
        self.loadCharacterUseCase = loadCharacterUseCase
        self.lastPageValidationUseCase = lastPageValidationUseCase
        self.imageDataUseCase = imageDataUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        Task {
            await loadCharacterUseCase()
        }
    }
    
    private func loadCharacterUseCase() async {
        let resultUseCase = await loadCharacterUseCase.execute()
        updateStateUI(resultUseCase: resultUseCase)
    }
    
    private func updateStateUI(resultUseCase: Result<[Character], Error>) {
        switch resultUseCase {
        case .success(let characters):
            lastPageValidationUseCase.updateLastPage(itemsCount: characters.count)
            self.characters.append(contentsOf: characters)
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
    }
    
    func getItemMenuViewModel(row: Int) -> CharacterTableViewCellViewModel {
        checkAndLoadMoreCharacters(row: row)
        
        return makeItemCharacterViewModel(row: row)
    }
    
    private func checkAndLoadMoreCharacters(row: Int) {
        lastPageValidationUseCase.checkAndLoadMoreItems(row: row,
                                                        actualItems: characters.count,
                                                        action: viewDidLoad)
    }
    
    private func makeItemCharacterViewModel(row: Int) -> CharacterTableViewCellViewModel {
        let character = characters[row]
        return CharacterTableViewCellViewModel(character: character, imageDataUseCase: imageDataUseCase)
    }
    
    func getUrlDetail(row: Int) -> String {
        let character = characters[row]
        return character.urlCharacter
    }
    
}
