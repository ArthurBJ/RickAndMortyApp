//
//  CharactersFactory.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 20.11.2023.
//

import UIKit
import Combine

protocol CharactersFactory {
    func makeModule(coordinator: CharactersViewControllerCoordinator) -> UIViewController
    func makeCharacterDetailCoordinator(navigation: UINavigationController, urlDetail: String) -> Coordinator
}

struct CharactersFactoryImpl: CharactersFactory {
    
    let appContainer: AppContainer
    let urlList: String
    
    func makeModule(coordinator: CharactersViewControllerCoordinator) -> UIViewController {
        let state = PassthroughSubject<StateController, Never>()
        let apiClient = ApiClientServiceImpl()
        let characterRepository = CharacterRepositoryImpl(apiClient: apiClient)
        let loadCharacterUseCase = LoadCharactersUseCaseImpl(characterRepository: characterRepository, url: urlList)
        let lastPageValidationUseCase = LastPageValidationUseCaseImpl()
        let viewModel = CharactersViewModelImpl(loadCharacterUseCase: loadCharacterUseCase, state: state, lastPageValidationUseCase: lastPageValidationUseCase, imageDataUseCase: appContainer.getDataImageUseCase())
        let controller = CharactersViewController(viewModel: viewModel, coordinator: coordinator)
        controller.title = "Characters"
        return controller
    }
    
    func makeCharacterDetailCoordinator(navigation: UINavigationController, urlDetail: String) -> Coordinator {
        let characterDetailFactory = CharacterDetailFactoryImpl(urlDetail: urlDetail, appContainer: appContainer)
        let coordinator = CharacterDetailCoordinator(navigation: navigation, characterDetailFactory: characterDetailFactory)
        return coordinator
    }
    
}
