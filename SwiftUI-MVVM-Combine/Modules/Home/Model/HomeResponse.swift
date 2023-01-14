//
//  HomeResponse.swift
//  SwiftUI-MVVM-Combine
//
//  Created by Mahmoud Ismail on 14/01/2023.
//

import Foundation

// MARK: - Welcome
struct HomeResponse: Codable {
    let products: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case products = "results"
    }
    
}

// MARK: - Product
struct Product: Codable, Identifiable {
    
    let createdAt, price, name, id: String?
    let imageUrls, imageUrlsThumbnails: [String]?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case price, name
        case id = "uid"
        case imageUrls = "image_urls"
        case imageUrlsThumbnails = "image_urls_thumbnails"
    }
    
}
