//
//  LocationFactory.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 22.11.2023.
//

import UIKit

protocol LocationDetailFactory {
    func makeModule() -> UIViewController
}

struct LocationDetailFactoryImpl: LocationDetailFactory {
    
    func makeModule() -> UIViewController {
        let controller = LocationDetailViewController()
        controller.title = "Location  Detail"
        return controller
    }
    
}
