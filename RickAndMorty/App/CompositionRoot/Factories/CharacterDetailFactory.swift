//
//  CharacterDetailFactory.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import UIKit
import Combine

protocol CharacterDetailFactory {
    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController
    
    func makeOriginCoordinator(navigation: UINavigationController) -> Coordinator
    func makeLocationCoordinator(navigation: UINavigationController) -> Coordinator
}

struct CharacterDetailFactoryImpl: CharacterDetailFactory {
    
    let urlDetail: String
    let appContainer: AppContainer
    
    func makeModule(coordinator: CharacterDetailViewControllerCoordinator) -> UIViewController {
        let characterDetailRepository = CharacterDetailRepositoryImpl(apiService: appContainer.apiClient)
        let loadCharacterDetailUseCase = LoadCharacterDetailUseCaseImpl(characterDetailRepository: characterDetailRepository, urlDetail: urlDetail)
        let state = PassthroughSubject<StateController, Never>()
        let viewModel = CharacterDetailViewModelImpl(state: state, loadCharacterDetailUseCase: loadCharacterDetailUseCase, dataImageUseCase: appContainer.getDataImageUseCase())
        let controller = CharacterDetailViewController(viewModel: viewModel, coordinator: coordinator)
        return controller
    }
    
    func makeOriginCoordinator(navigation: UINavigationController) -> Coordinator {
        let factory = OriginFactoryImpl()
        let coordinator = OriginCoordiantor(originFactory: factory, navigation: navigation)
        return coordinator
    }
    
    func makeLocationCoordinator(navigation: UINavigationController) -> Coordinator {
        let factory = LocationDetailFactoryImpl()
        let coordinator = LocationDetailCoordinator(locationFactory: factory, navigation: navigation)
        return coordinator
    }
    
}
