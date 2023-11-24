//
//  HomeFactory.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 19.11.2023.
//

import UIKit
import Combine

protocol HomeFactory {
    func makeModule(coordinator: HomeMenuViewControllerCoordinator) -> UIViewController
    func makeCharactersCoordinator(navigation: UINavigationController, urlList: String) -> Coordinator
    func makeLocationsCoordinator(navigation: UINavigationController, urlLocations: String) -> Coordinator
    func makeEpisodesCoordinator(navigation: UINavigationController, urlEpisodes: String) -> Coordinator
}

struct HomeFactoryImpl: HomeFactory {
    
    let appContainer: AppContainer
    
    func makeModule(coordinator: HomeMenuViewControllerCoordinator) -> UIViewController {
        let apiClientService = ApiClientServiceImpl()
        let menuRepository = MenuRepositoryImpl(apiClientService: apiClientService, urlList: Endpoint.baseUrl)
        let loadMenuUseCase = LoadMenuUseCaseImpl(menuRepository: menuRepository)
        let state = PassthroughSubject<StateController, Never>()
        let homeMenuViewModel = HomeMenuViewModelImpl(state: state, loadMenuUseCase: loadMenuUseCase)
        let homeMenuController = HomeMenuController(viewModel: homeMenuViewModel, layout: makeLayout(), coordinator: coordinator)
        homeMenuController.title = AppLocalized.appName
        return homeMenuController
    }
    
    private func makeLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let layoutWidth = (ViewValues.widthScreen - ViewValues.doublePadding) / ViewValues.multiplierTwo
        let layoutHeight = (ViewValues.widthScreen - ViewValues.doublePadding) / ViewValues.multiplierTwo
        layout.itemSize = CGSize(width: layoutWidth, height: layoutHeight)
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.sectionInset = UIEdgeInsets(top: .zero, left: ViewValues.normalPadding, bottom: .zero, right: ViewValues.normalPadding)
        return layout
    }
    
    func makeCharactersCoordinator(navigation: UINavigationController, urlList: String) -> Coordinator {
        let charactersFactory = CharactersFactoryImpl(appContainer: appContainer, urlList: urlList)
        let characterCoordinator = CharactersCoordinator(navigation: navigation, charactersFactory: charactersFactory)
        
        return characterCoordinator
    }
    
    func makeLocationsCoordinator(navigation: UINavigationController, urlLocations: String) -> Coordinator {
        let locationFactory = LocationsFactoryImpl(urlLocations: urlLocations, appContainer: appContainer)
        let locationsCoordinator = LocationsCoordinator(locationFactory: locationFactory, navigation: navigation)
        return locationsCoordinator
    }
    
    func makeEpisodesCoordinator(navigation: UINavigationController, urlEpisodes: String) -> Coordinator {
        let episodesFactory = EpisodesFactoryImpl(urlEpisodes: urlEpisodes, appContainer: appContainer)
        let episodesCoordinator = EpisodesCoordinator(episodesFactory: episodesFactory, navigation: navigation)
        return episodesCoordinator
    }
    
}
