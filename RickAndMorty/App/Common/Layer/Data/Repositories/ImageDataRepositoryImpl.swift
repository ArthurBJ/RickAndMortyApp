//
//  ImageDataRepositoryImpl.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

struct ImageDataRepositoryImpl: ImageDataRepository {
    
    private(set) var remoteDataService: RemoteImageDataService
    private(set) var localDataCache: LocalDataImageService
    
    func fetchData(url: URL?) async -> Data? {
        let data = await remoteDataService.request(url: url)
        localDataCache.save(key: url?.absoluteString ?? .empty, data: data)
        return data
    }
    
    func getFromCache(url: String?) -> Data? {
        localDataCache.get(key: url ?? .empty)
    }
    
}
