//
//  APIService.swift
//  SwiftUI-MVVM-Combine
//
//  Created by Mahmoud Ismail on 14/01/2023.
//

import Foundation
import Combine

protocol APIServiceType {
    func response<T>(from endPoint: String) -> AnyPublisher<T, APIServiceError> where T: Decodable
    func downloadData(from urlPath: String) -> AnyPublisher<Data, APIServiceError>
}

final class APIService: APIServiceType {
    
    static let shared: APIServiceType = APIService()
    
    private let baseURL: URL?
    private let session: URLSession
    
    init(session: URLSession = .shared, urlPath: String = "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com") {
        self.baseURL = URL(string: urlPath)
        self.session = session
    }
    
    func response<T>(from endPoint: String) -> AnyPublisher<T, APIServiceError> where T: Decodable {
        
        guard let urlRequest = getURLRequest(from: endPoint) else {
            let error = APIServiceError.invalidURL(description: "Can't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
            .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
    func downloadData(from urlPath: String) -> AnyPublisher<Data, APIServiceError> {
        guard let pathURL: URL = URL(string:urlPath),
              let urlComponents: URLComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true),
              let url: URL = urlComponents.url else {
                  let error = APIServiceError.invalidURL(description: "Can't create URL")
                  return Fail(error: error).eraseToAnyPublisher()
              }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .tryMap { response -> Data in
                guard
                    let httpURLResponse = response.response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200
                else {
                    throw  APIServiceError.network(description: "Invalid Status Code")
                }
                
                return response.data
            }
            .mapError { error in
            .network(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    private func getURLRequest(from endPoint: String) -> URLRequest? {
        guard let pathURL: URL = URL(string: endPoint, relativeTo: baseURL) else {
            return nil
        }
        let urlComponents: URLComponents? = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)
        guard let url: URL = urlComponents?.url else {
            return nil
        }
        return URLRequest(url: url)
    }
    
}
