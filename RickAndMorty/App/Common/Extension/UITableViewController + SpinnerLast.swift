//
//  UITableViewController + SpinnerLast.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import UIKit

extension UITableViewController {
    
    func addSpinnerLastCell() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: .zero, y: .zero, width: tableView.bounds.width, height: ViewValues.defaultHeightCell)
        tableView.tableFooterView = spinner
    }
}
