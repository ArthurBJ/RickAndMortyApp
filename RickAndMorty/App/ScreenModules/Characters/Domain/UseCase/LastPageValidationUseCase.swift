//
//  LastPageValidationUseCase.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Foundation

protocol LastPageValidationUseCase {
    var lastPage: Bool { get }
    mutating func updateLastPage(itemsCount: Int)
    func checkAndLoadMoreItems(row: Int, actualItems: Int, action: () -> Void)
}

struct LastPageValidationUseCaseImpl: LastPageValidationUseCase {
    
    private var threshold: Int = 5
    var lastPage: Bool = false
    
    mutating func updateLastPage(itemsCount: Int) {
        if itemsCount == Int.zero {
            lastPage = true
        }
    }
    
    func checkAndLoadMoreItems(row: Int, actualItems: Int, action: () -> Void) {
        guard !lastPage else { return }
        let limit = actualItems - threshold
        if limit == row {
            action()
        }
    }
    
}
