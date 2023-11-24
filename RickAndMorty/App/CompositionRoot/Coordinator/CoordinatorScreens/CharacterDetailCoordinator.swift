//
//  CharacterDetailCoordinator.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import UIKit

final class CharacterDetailCoordinator: Coordinator {
    
    var navigation: UINavigationController
    private var characterDetailFactory: CharacterDetailFactory
    
    init(navigation: UINavigationController, characterDetailFactory: CharacterDetailFactory) {
        self.navigation = navigation
        self.characterDetailFactory = characterDetailFactory
    }
    
    func start() {
        let controller = characterDetailFactory.makeModule(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
    
}

extension CharacterDetailCoordinator: CharacterDetailViewControllerCoordinator {
    func didTapOriginButton() {
        let coordinator = characterDetailFactory.makeOriginCoordinator(navigation: navigation)
        coordinator.start()
    }
    
    func didTapLocationButton() {
        let coordinator = characterDetailFactory.makeLocationCoordinator(navigation: navigation)
        coordinator.start()
    }
    
}
