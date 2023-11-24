//
//  AppContainer.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

protocol AppContainer {
    var apiClient: ApiClientService & RemoteImageDataService { get }
    var localDataService: LocalDataImageService { get }
    func getDataImageUseCase() -> ImageDataUseCase
}

struct AppContainerImpl: AppContainer {
    
    var apiClient: ApiClientService & RemoteImageDataService = ApiClientServiceImpl()
    
    var localDataService: LocalDataImageService = LocalDataImageServiceImpl()
    
    func getDataImageUseCase() -> ImageDataUseCase {
        let imageDataRepository = ImageDataRepositoryImpl(remoteDataService: apiClient, localDataCache: localDataService)
        return ImageDataUseCaseImpl(imageDataRepository: imageDataRepository)
    }
    
}
