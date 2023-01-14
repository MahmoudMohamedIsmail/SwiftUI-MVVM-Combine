//
//  ImageSliderView.swift
//  SwiftUI-MVVM-Combine
//
//  Created by Mahmoud Ismail on 14/01/2023.
//

import SwiftUI

struct ImageSliderView<Model>: View where Model: Downloadable {
    
    private let product: Product
    @State private var image: UIImage = UIImage()
    @State private var showLoading: Bool = true
    @ObservedObject private var viewModel: Model
    
    init(product: Product, viewModel: Model) {
        self.product = product
        self.viewModel = viewModel
    }
    
    var body: some View {
        TabView {
            ForEach(product.imageUrls ?? [], id: \.self) { item in
                ZStack {
                    Image(uiImage: image)
                        .resizable()
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
        .tabViewStyle(PageTabViewStyle())
    }
}
