//
//  RemoteImageDataService.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

protocol RemoteImageDataService {
    func request(url: URL?) async -> Data?
}
