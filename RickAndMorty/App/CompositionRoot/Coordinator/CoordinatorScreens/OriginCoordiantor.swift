//
//  OriginCoordiantor.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 22.11.2023.
//

import UIKit

final class OriginCoordiantor: Coordinator {
    
    private var originFactory: OriginFactory
    var navigation: UINavigationController
    
    init(originFactory: OriginFactory, navigation: UINavigationController) {
        self.originFactory = originFactory
        self.navigation = navigation
    }
    
    func start() {
        let controller = originFactory.makeModule()
        navigation.pushViewController(controller, animated: true)
    }
    
}
