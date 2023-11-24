//
//  ResultsCharactersDTO + Mapper.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

extension ResultsCharactersDTO {
    func toDomain() -> (info: Info, characters: [Character]) {
        let charactersModel = results.map {
            let statusCharacter = StatusCharacter(status: $0.status)
            let specie = Specie(specie: $0.species)
            let origin = Origin(name: $0.origin.name, url: $0.origin.url)
            let location = Location(name: $0.location.name,
                                    type: $0.location.type,
                                    dimension: $0.location.dimension,
                                    url: $0.location.url)
            return Character(id: $0.id,
                                      name: $0.name,
                                      status: statusCharacter,
                                      specie: specie,
                                      urlCharacter: $0.url,
                                      urlImage: $0.image,
                                      origin: origin,
                                      loaction: location)
            
            
        }
        let info = Info(next: info.next)
        
        return (info: info, characters: charactersModel)
    }
}
