//
//  DynamicWidthCardView.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct DynamicWidthCardView: CardType {
    
    @ObservedObject var cardVM: CardViewModel
    private let height: Double
    @Environment(\.openURL) var openURL
    
    var cardHeight: CGFloat {
        CGFloat(height)
    }
    
    init(_ cardVM: CardViewModel, with height: Double) {
        self.cardVM = cardVM
        self.height = height
        print("HC9", height)
    }
    
    var body: some View {
        VStack {
            Spacer()
            Button(action: onTap) {
                HC9BackgroundView(url: cardVM.bgImageUrl, asset: cardVM.bgAsset)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity)
            .frame(height: cardHeight)
            .cornerRadius(10)
            Spacer()
        }
    }
    
    func onTap() {
        if !cardVM.url.isEmpty {
            if let url = URL(string: cardVM.url) {
                openURL(url)
            }
        }
    }
}
