//
//  BaseViewModel.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 21.11.2023.
//

import Combine

protocol BaseViewModel {
    var state: PassthroughSubject<StateController, Never> { get }
    func viewDidLoad()
}
