//
//  HomeRepository.swift
//  SwiftUI-MVVM-Combine
//
//  Created by Mahmoud Ismail on 14/01/2023.
//

import Foundation
import Combine

protocol HomeRepositoryInterface {
    func fetchProducts() -> AnyPublisher<HomeResponse, APIServiceError>
    func fetchProductPhoto(with urlPath: String) -> AnyPublisher<Data, APIServiceError>
}

class HomeRepository: HomeRepositoryInterface {
    
    private let apiService: APIServiceType
    
    init(apiService: APIServiceType = APIService.shared) {
        self.apiService = apiService
    }
    
    func fetchProducts() -> AnyPublisher<HomeResponse, APIServiceError> {
        let endPoint: String = "/default/dynamodb-writer"
        return apiService.response(from: endPoint)
    }
    
    func fetchProductPhoto(with urlPath: String) -> AnyPublisher<Data, APIServiceError> {
        return apiService.downloadData(from: urlPath)
    }
    
}
