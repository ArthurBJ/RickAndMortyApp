//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 20.11.2023.
//

import UIKit
import Combine

protocol CharactersViewControllerCoordinator: AnyObject {
    func didSelectCell(urlDetail: String)
}

class CharactersViewController: UITableViewController {
    
    private let viewModel: CharactersViewModel
    private var cancellable = Set<AnyCancellable>()
    private var coordinator: CharactersViewControllerCoordinator
    
    init(viewModel: CharactersViewModel, coordinator: CharactersViewControllerCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        configTableView()
        stateController()
    }
    
    private func configTableView() {
        tableView.separatorStyle = .none
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.reuseId)
        addSpinnerLastCell()
    }
    
    private func stateController() {
        viewModel
            .state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                switch state {
                case .success:
                    self?.tableView.reloadData()
                case .loading:
                    break
                case .fail(error: let error):
                    self?.presentAlert(message: error, title: AppLocalized.error)
                }
            }.store(in: &cancellable)
    }
    
}

// MARK: - TableViewDataSource

extension CharactersViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemCharactersCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.reuseId, for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }
        let row = indexPath.row
        let cellViewModel = viewModel.getItemMenuViewModel(row: row)
        cell.configData(viewModel: cellViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            tableView.tableFooterView?.isHidden = viewModel.lastPage
    }
}

// MARK: - Delegate

extension CharactersViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        let urlDetail = viewModel.getUrlDetail(row: row)
        coordinator.didSelectCell(urlDetail: urlDetail)
    }
}

extension CharactersViewController: MessageDisplayable { }
