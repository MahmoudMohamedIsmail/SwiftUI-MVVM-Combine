//
//  ProductDetailsView.swift
//  SwiftUI-MVVM-Combine
//
//  Created by Mahmoud Ismail on 14/01/2023.
//

import SwiftUI

struct ProductDetailsView<Model>: View where Model: Downloadable {
    
    private let product: Product
    @State private var image: UIImage = UIImage()
    @State private var showLoading: Bool = true
    @ObservedObject private var viewModel: Model
    
    init(product: Product, viewModel: Model) {
        self.product = product
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 12) {
            ImageSliderView(product: product, viewModel: viewModel)
                .aspectRatio(1, contentMode: .fit)
                .cornerRadius(4)
            Text(product.price ?? "")
                .applyPrimaryTitleStyle()
            Spacer()
        }
        .padding()
        .navigationBarTitle(product.name ?? "")
    }
    
}
