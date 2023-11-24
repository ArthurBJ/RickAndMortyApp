//
//  EpisodesViewModel.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 23.11.2023.
//

import Combine

protocol EpisodesViewModel: BaseViewModel {
    var itemsEpisodeCount: Int { get }
    var lastPage: Bool { get }
    func getCellEpisodeViewModel(row: Int) -> EpisodesTableViewCellViewModel
}

final class EpisodesViewModelImpl: EpisodesViewModel {
    
    var state: PassthroughSubject<StateController, Never>
    var itemsEpisodeCount: Int {
        return episodes.count
    }
    var lastPage: Bool {
        return lastPageUseCase.lastPage
    }
    
    private(set) var loadEpisodesUseCase: LoadEpisodesUseCase
    private(set) var lastPageUseCase: LastPageValidationUseCase
    private var episodes: [Episode] = []
    
    init(state: PassthroughSubject<StateController, Never>, loadEpisodesUseCase: LoadEpisodesUseCase, lastPageUseCase: LastPageValidationUseCase) {
        self.state = state
        self.loadEpisodesUseCase = loadEpisodesUseCase
        self.lastPageUseCase = lastPageUseCase
    }
    
    func viewDidLoad() {
        state.send(.loading)
        Task {
            let result = await loadEpisodesUseCase.getEpisodes()
            switch result {
            case .success(let episodesResult):
                lastPageUseCase.updateLastPage(itemsCount: episodesResult.count)
                episodes.append(contentsOf: episodesResult)
                state.send(.success)
            case .failure(let error):
                state.send(.fail(error: error.localizedDescription))
            }
        }
    }
    
    func getCellEpisodeViewModel(row: Int) -> EpisodesTableViewCellViewModel {
        lastPageUseCase.checkAndLoadMoreItems(row: row, actualItems: episodes.count, action: viewDidLoad)
        
        let episode = episodes[row]
        return EpisodesTableViewCellViewModel(episode: episode)
    }
    
}
