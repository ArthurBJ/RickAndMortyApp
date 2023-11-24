//
//  MenuRepository.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 19.11.2023.
//

import Foundation

protocol MenuRepository {
    func fetchMenuData() async throws -> [MenuItem]
}
