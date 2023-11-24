//
//  LocationsFactory.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 22.11.2023.
//

import UIKit
import Combine

protocol LocationsFactory {
    func makeModule() -> UIViewController
}

struct LocationsFactoryImpl: LocationsFactory {
    
    private(set) var urlLocations: String
    private(set) var appContainer: AppContainer
    
    func makeModule() -> UIViewController {
        let locationsRepository = LocationsRepositoryImpl(apiService: appContainer.apiClient)
        let loadLocationUseCase = LoadLocationsUseCaseImpl(locationsRepository: locationsRepository, urlLocations: urlLocations)
        let state = PassthroughSubject<StateController, Never>()
        let lastPageUseCase = LastPageValidationUseCaseImpl()
        let viewModel = LocationsViewModelImpl(state: state, loadLocationUseCase: loadLocationUseCase, lastPageUseCase: lastPageUseCase)
        let controller = LocationsViewController(viewModel: viewModel)
        controller.title = AppLocalized.locations
        return controller
    }
    
}
