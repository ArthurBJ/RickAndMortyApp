//
//  AppFactory.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 19.11.2023.
//

import UIKit

protocol AppFactory {
    func markHomeCoordinator(navigation: UINavigationController) -> Coordinator
}

struct AppFactoryImpl: AppFactory {
    
    let appContainer = AppContainerImpl()
    
    func markHomeCoordinator(navigation: UINavigationController) -> Coordinator {
        let homeFactory = HomeFactoryImpl(appContainer: appContainer)
        let homeCoordinator = HomeCoordinator(navigation: navigation, homeFactory: homeFactory)
        return homeCoordinator
    }
    
}

