//
//  LocationsCoordinator.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 22.11.2023.
//

import UIKit

final class LocationsCoordinator: Coordinator {
    
    private let locationFactory: LocationsFactory
    var navigation: UINavigationController
    
    init(locationFactory: LocationsFactory, navigation: UINavigationController) {
        self.locationFactory = locationFactory
        self.navigation = navigation
    }
    
    func start() {
        let controller = locationFactory.makeModule()
        navigation.pushViewController(controller, animated: true)
        navigation.navigationBar.prefersLargeTitles = true
    }
    
}
