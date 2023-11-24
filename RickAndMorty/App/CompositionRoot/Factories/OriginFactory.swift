//
//  OriginFactory.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 22.11.2023.
//

import UIKit

protocol OriginFactory {
    func makeModule() -> UIViewController
}

struct OriginFactoryImpl: OriginFactory {
    func makeModule() -> UIViewController {
        let controller = OriginViewController()
        controller.title = "Origin"
        return controller
    }
    
    
}
