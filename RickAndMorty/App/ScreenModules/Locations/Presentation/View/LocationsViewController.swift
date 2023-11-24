//
//  LocationsViewController.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 22.11.2023.
//

import UIKit
import Combine

class LocationsViewController: UITableViewController {
    
    private let viewModel: LocationsViewModel
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: LocationsViewModel) {
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
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.reuseId)
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

extension LocationsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsLocationsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseId, for: indexPath) as? LocationTableViewCell else { return UITableViewCell() }
        
        let cellViewModel = viewModel.getItemLocationViewModel(row: indexPath.row)
        cell.configData(viewModel: cellViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.tableFooterView?.isHidden = viewModel.lastPage
    }
}

extension LocationsViewController: MessageDisplayable { }
