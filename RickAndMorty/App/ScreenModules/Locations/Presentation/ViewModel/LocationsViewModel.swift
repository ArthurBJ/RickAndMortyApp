//
//  LocationsViewModel.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 23.11.2023.
//

import Foundation
import Combine

protocol LocationsViewModel: BaseViewModel {
    var itemsLocationsCount: Int { get }
    var lastPage: Bool { get }
    func getItemLocationViewModel(row: Int) -> LocationTableViewCellViewModel
}

final class LocationsViewModelImpl: LocationsViewModel {
    
    var itemsLocationsCount: Int {
        return locations.count
    }
    var lastPage: Bool {
        return lastPageUseCase.lastPage
    }
    var state: PassthroughSubject<StateController, Never>
    
    private var loadLocationUseCase: LoadLocationsUseCase
    private var lastPageUseCase: LastPageValidationUseCase
    private var locations: [Location] = []
    
    init(state: PassthroughSubject<StateController, Never>, loadLocationUseCase: LoadLocationsUseCase, lastPageUseCase: LastPageValidationUseCase) {
        self.state = state
        self.loadLocationUseCase = loadLocationUseCase
        self.lastPageUseCase = lastPageUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        Task { [weak self] in
            let result = await loadLocationUseCase.execute()
            switch result {
            case .success(let locations):
                lastPageUseCase.updateLastPage(itemsCount: locations.count)
                self?.locations.append(contentsOf: locations)
                state.send(.success)
            case .failure(let error):
                state.send(.fail(error: error.localizedDescription))
            }
        }
    }
    
    func getItemLocationViewModel(row: Int) -> LocationTableViewCellViewModel {
        checkAndLoadMoreItems(row: row)
        let location = locations[row]
        let cellLocationViewModel = LocationTableViewCellViewModel(location: location)
        return cellLocationViewModel
    }
    
    private func checkAndLoadMoreItems(row: Int) {
        lastPageUseCase.checkAndLoadMoreItems(row: row, actualItems: locations.count, action: viewDidLoad)
    }
    
}
