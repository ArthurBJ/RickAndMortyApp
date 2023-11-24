//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 19.11.2023.
//

import UIKit

protocol Coordinator {
    var navigation: UINavigationController { get }
    func start()
}
