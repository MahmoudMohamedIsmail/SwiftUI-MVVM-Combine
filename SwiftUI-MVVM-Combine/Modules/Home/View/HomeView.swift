//
//  HomeView.swift
//  SwiftUI-MVVM-Combine
//
//  Created by Mahmoud Ismail on 14/01/2023.
//

import SwiftUI

private let defaultPadding: CGFloat = 16

struct HomeView<Model>: View where Model: HomeViewModelInterface {
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: defaultPadding), count: 2)
    @ObservedObject var viewModel: Model
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: defaultPadding) {
                    ForEach(viewModel.products) { product in
                        NavigationLink {
                            ProductDetailsView(product: product, viewModel: viewModel)
                        } label: {
                            ProductCell(product: product, viewModel: viewModel)
                        }
                    }
                }
                .padding(defaultPadding)
            }.navigationBarTitle("Home")
        } .overlay {
            if viewModel.showLoading {
                ProgressView("Loading")
            }
        }
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}
