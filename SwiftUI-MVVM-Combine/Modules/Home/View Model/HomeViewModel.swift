//
//  HomeViewModel.swift
//  SwiftUI-MVVM-Combine
//
//  Created by Mahmoud Ismail on 14/01/2023.
//

import Foundation
import SwiftUI
import Combine

protocol HomeViewModelInterface: BaseViewModel, Downloadable {
    var products: [Product] { get set }
    init(repository: HomeRepositoryInterface)
    func fetchProducts()
}

protocol Downloadable: ObservableObject {
    var cachedProductsPhotos: [String: Data?] { get set }
    func downloadPhoto(_ url: String)
}

class HomeViewModel: HomeViewModelInterface {
    
    @Published var products: [Product]
    @Published var cachedProductsPhotos: [String: Data?]
    @Published var showLoading: Bool
    private var disposables = Set<AnyCancellable>()
    private let repository: HomeRepositoryInterface
    
    required init(repository: HomeRepositoryInterface = HomeRepository()) {
        self.repository = repository
        self.products = [Product]()
        self.cachedProductsPhotos = [String: Data?]()
        self.showLoading = true
    }
    
    func fetchProducts() {
        showLoading = true
        repository
            .fetchProducts()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.products = []
                case .finished:
                    break
                }
            } receiveValue: { [weak self] result in
                self?.showLoading = false
                self?.products = result.products ?? []
            }
            .store(in: &disposables)
    }
    
    func downloadPhoto(_ url: String) {
        repository
            .fetchProductPhoto(with: url)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.cachedProductsPhotos[url] = nil
                case .finished:
                    break
                }
            } receiveValue: { [weak self] imageData in
                self?.cachedProductsPhotos[url] = imageData
            }
            .store(in: &disposables)
    }
    
}
