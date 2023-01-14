//
//  APIServiceError.swift
//  SwiftUI-MVVM-Combine
//
//  Created by Mahmoud Ismail on 14/01/2023.
//

import Foundation

enum APIServiceError: Error {
    case parsing(description: String)
    case network(description: String)
    case invalidURL(description: String)
}
