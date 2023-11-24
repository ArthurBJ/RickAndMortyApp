//
//  HomeMenuViewModel.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 19.11.2023.
//

import Foundation
import Combine

protocol HomeMenuViewModel {
    var state: PassthroughSubject<StateController, Never> { get }
    var menuItemsCount: Int { get }
    func viewDidLoad()
    func getItemMenuViewModel(indexPath: IndexPath) -> HomeMenuCollectionViewCellViewModel
    func getMenuItem(indexPath: IndexPath) -> MenuItem
}

final class HomeMenuViewModelImpl: HomeMenuViewModel {
    
    var state: PassthroughSubject<StateController, Never>
    
    var menuItemsCount: Int {
        return menuItems.count
    }
    
    private let loadMenuUseCase: LoadMenuUseCase
    private var menuItems: [MenuItem] = []
    
    init(state: PassthroughSubject<StateController, Never>, loadMenuUseCase: LoadMenuUseCase) {
        self.state = state
        self.loadMenuUseCase = loadMenuUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        Task {
            let result = await loadMenuUseCase.execute()
            await updateUI(result: result)
        }
    }
    
    @MainActor private func updateUI(result: Result<[MenuItem], Error>) {
        switch result {
        case .success(let menuItems):
            self.menuItems = menuItems
            state.send(.success)
        case .failure(let error):
            state.send(.fail(error: error.localizedDescription))
        }
    }
    
    func getItemMenuViewModel(indexPath: IndexPath) -> HomeMenuCollectionViewCellViewModel {
        let menuItem = menuItems[indexPath.row]
        return HomeMenuCollectionViewCellViewModel(menuItem: menuItem)
    }
    
    func getMenuItem(indexPath: IndexPath) -> MenuItem {
        return menuItems[indexPath.row]
    }
    
    
}
