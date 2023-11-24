//
//  LocationCoordinator.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 22.11.2023.
//

import UIKit

final class LocationDetailCoordinator: Coordinator {
    
    private var locationDetailFactory: LocationDetailFactory
    var navigation: UINavigationController
    
    init(locationFactory: LocationDetailFactory, navigation: UINavigationController) {
        self.locationDetailFactory = locationFactory
        self.navigation = navigation
    }
    
    func start() {
        let controller = locationDetailFactory.makeModule()
        navigation.pushViewController(controller, animated: true)
    }
    
}
