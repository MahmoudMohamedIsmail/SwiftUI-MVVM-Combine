//
//  ProductCell.swift
//  SwiftUI-MVVM-Combine
//
//  Created by Mahmoud Ismail on 14/01/2023.
//

import SwiftUI

struct ProductCell<Model>: View where Model: Downloadable {
    
    private let product: Product
    @State private var image: UIImage = UIImage()
    @State private var showLoading: Bool = true
    @ObservedObject private var viewModel: Model
    
    init(product: Product, viewModel: Model) {
        self.product = product
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .onChange(of: viewModel.cachedProductsPhotos) { cachedPhotos in
                        guard let data: Data = cachedPhotos[(product.imageUrls?.first) ?? ""] as? Data,
                              let photo: UIImage = UIImage(data: data) else {
                                  showLoading = true
                                  return }
                        showLoading = false
                        image = photo
                    }
            }.overlay {
                if showLoading {
                    ProgressView()
                }
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(product.name ?? "")
                    .applySecondaryTitleStyle()
                    .lineLimit(2)
                Text(product.price ?? "")
                    .applyPrimaryTitleStyle()
            }
            .padding(12)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
        .onAppear {
            guard let url: String = product.imageUrls?.first else { return }
            let isCashed: Bool = viewModel.cachedProductsPhotos[url] != nil
            showLoading = isCashed == false
            if isCashed,
               let data: Data = viewModel.cachedProductsPhotos[url] as? Data {
                image = UIImage(data: data) ?? UIImage()
            } else {
                viewModel.downloadPhoto(url)
            }
        }
    }
    
}
