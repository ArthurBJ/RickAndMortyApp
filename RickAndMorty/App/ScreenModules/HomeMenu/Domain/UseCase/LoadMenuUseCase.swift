//
//  LoadMenuUseCase.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 19.11.2023.
//

import Foundation

protocol LoadMenuUseCase {
    func execute() async -> Result<[MenuItem], Error>
}

struct LoadMenuUseCaseImpl: LoadMenuUseCase {
    
    let menuRepository: MenuRepository
    
    func execute() async -> Result<[MenuItem], Error> {
        do {
            let repository = try await menuRepository.fetchMenuData()
            return .success(repository)
        } catch let error {
            return .failure(error)
        }
        
    }
    
    
}
