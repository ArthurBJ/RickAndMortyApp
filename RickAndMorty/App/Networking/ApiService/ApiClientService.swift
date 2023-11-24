//
//  ApiClientService.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 20.11.2023.
//

import Foundation

protocol ApiClientService {
    func request<T: Decodable>(url: URL?, type: T.Type) async throws -> T
}
