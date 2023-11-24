//
//  ApiClientServiceImpl + RemoteImageDataService.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

extension ApiClientServiceImpl: RemoteImageDataService {
    
    func request(url: URL?) async -> Data? {
        guard let url = url else { return nil }
        do {
            let (data: data, request: request) = try await session.data(from: url)
            return (data: data, request: request).data
        } catch {
            return nil
        }
    }
    
}
