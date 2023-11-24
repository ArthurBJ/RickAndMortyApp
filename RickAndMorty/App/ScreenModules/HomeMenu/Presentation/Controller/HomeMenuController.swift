//
//  HomeMenuController.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 18.11.2023.
//

import UIKit
import Combine

protocol HomeMenuViewControllerCoordinator: AnyObject {
    func didSelectMenuCell(model: MenuItem)
}

final class HomeMenuController: UICollectionViewController {
    
    private let viewModel: HomeMenuViewModel
    private var cancellable = Set<AnyCancellable>()
    private weak var coordinator: HomeMenuViewControllerCoordinator?
    
    init(viewModel: HomeMenuViewModel, layout: UICollectionViewFlowLayout, coordinator: HomeMenuViewControllerCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configCollectionView()
        stateController()
        viewModel.viewDidLoad()
    }
    
    private func stateController() {
        viewModel
            .state
            .sink { [weak self] state in
                self?.hideSpinner()
            switch state {
            case .success:
                self?.collectionView.reloadData()
            case .loading:
                self?.showSpinner()
            case .fail(error: let error):
                self?.presentAlert(message: error, title: AppLocalized.error)
            }
        }.store(in: &cancellable)
    }

    private func configUI() {
        view.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true
    }
    
    private func configCollectionView() {
        collectionView.register(HomeMenuCollectionViewCell.self, forCellWithReuseIdentifier: HomeMenuCollectionViewCell.reuseId)
    }

}

extension HomeMenuController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.menuItemsCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMenuCollectionViewCell.reuseId, for: indexPath) as? HomeMenuCollectionViewCell else { return UICollectionViewCell() }
        let viewModelCell = viewModel.getItemMenuViewModel(indexPath: indexPath)
        cell.configData(viewModel: viewModelCell)
        return cell
    }
}

extension HomeMenuController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let model = viewModel.getMenuItem(indexPath: indexPath)
        coordinator?.didSelectMenuCell(model: model)
    }
}

extension HomeMenuController: SpinnerDisplayable { }

extension HomeMenuController: MessageDisplayable { }
