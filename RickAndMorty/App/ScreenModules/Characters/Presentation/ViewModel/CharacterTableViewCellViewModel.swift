//
//  CharacterTableViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

struct CharacterTableViewCellViewModel {
    
    private(set) var character: Character
    private(set) var imageDataUseCase: ImageDataUseCase
    
    var name: String {
        return character.name
    }
    
    var specie: String {
        return character.specie.description
    }
    
    var status: String {
        return character.status?.description ?? ""
    }
    
    var imageData: Data? {
        imageDataUseCase.getDataFromCache(url: character.urlImage ?? .empty)
    }
    
    func getImageData() async -> Data? {
        let url = URL(string: character.urlImage ?? .empty)
        return await imageDataUseCase.getData(url: url)
    }
}
