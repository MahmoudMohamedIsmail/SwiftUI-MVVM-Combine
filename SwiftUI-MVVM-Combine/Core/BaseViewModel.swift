//
//  BaseViewModel.swift
//  SwiftUI-MVVM-Combine
//
//  Created by Mahmoud Ismail on 14/01/2023.
//

import Foundation

protocol BaseViewModel: ObservableObject {
    var showLoading: Bool { get set }
}
