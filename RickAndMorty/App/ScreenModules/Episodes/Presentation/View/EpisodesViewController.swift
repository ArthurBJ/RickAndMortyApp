//
//  EpisodesViewController.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 23.11.2023.
//

import UIKit
import Combine

class EpisodesViewController: UITableViewController {
    
    private let viewModel: EpisodesViewModel
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: EpisodesViewModel) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        stateController()
        addSpinnerLastCell()
        viewModel.viewDidLoad()
    }
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        tableView.register(EpisodesTableViewCell.self, forCellReuseIdentifier: EpisodesTableViewCell.reuseId)
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
                    self?.presentAlert(message: error, title: "Error")
                }
            }.store(in: &cancellable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TableViewDataSource

extension EpisodesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsEpisodeCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodesTableViewCell.reuseId, for: indexPath) as? EpisodesTableViewCell else { return UITableViewCell() }
        let cellViewModel = viewModel.getCellEpisodeViewModel(row: indexPath.row)
        cell.configData(viewModel: cellViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.tableFooterView?.isHidden = viewModel.lastPage
    }
}

extension EpisodesViewController: MessageDisplayable { }
