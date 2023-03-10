//
//  SwiftUI_MVVM_CombineApp.swift
//  SwiftUI-MVVM-Combine
//
//  Created by Mahmoud Ismail on 14/01/2023.
//

import SwiftUI

@main
struct SwiftUI_MVVM_CombineApp: App {
    
    private let viewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: viewModel)
        }
    }
    
}
