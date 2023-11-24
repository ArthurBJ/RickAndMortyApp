//
//  EpisodesFactory.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 23.11.2023.
//

import UIKit
import Combine

protocol EpisodesFactory {
    func makeModule() -> UIViewController
}

struct EpisodesFactoryImpl: EpisodesFactory {
    
    private(set) var urlEpisodes: String
    private(set) var appContainer: AppContainer
    
    func makeModule() -> UIViewController {
        let episodeRepository = EpisodesRepositoryImpl(apiClient: appContainer.apiClient)
        let loadEpisodesUseCase = LoadEpisodesUseCaseImpl(episodeRepository: episodeRepository, urlEpisodes: urlEpisodes)
        let lastPageUseCase = LastPageValidationUseCaseImpl()
        let state = PassthroughSubject<StateController, Never>()
        let episodesViewModel = EpisodesViewModelImpl(state: state, loadEpisodesUseCase: loadEpisodesUseCase, lastPageUseCase: lastPageUseCase)
        let controller = EpisodesViewController(viewModel: episodesViewModel)
        controller.title = "Episodes"
        return controller
    }
    
}
