//
//  HomeMenuCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 19.11.2023.
//

import Foundation

struct HomeMenuCollectionViewCellViewModel {
    
    private let menuItem: MenuItem
    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
    }
    
    var title: String {
        menuItem.title.capitalized
    }
    
    var imageName: String {
        menuItem.title
    }
}
