//
//  MessageDisplayable.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 20.11.2023.
//

import UIKit

protocol MessageDisplayable {}

extension MessageDisplayable where Self: UIViewController {
    func presentAlert(message: String, title: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: AppLocalized.okButton, style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
