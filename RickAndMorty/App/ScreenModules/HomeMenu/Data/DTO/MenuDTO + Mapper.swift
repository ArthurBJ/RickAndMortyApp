//
//  MenuDTO + Mapper.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 20.11.2023.
//

import Foundation

extension MenuDTO {
    
    func toDomain() -> [MenuItem] {
        return self.dictionaryProperties().map { dictionary in
            let title = dictionary.key
            let url: String = (dictionary.value as? String) ?? ""
            return MenuItem(title: title, url: url)
        }
    }
}
