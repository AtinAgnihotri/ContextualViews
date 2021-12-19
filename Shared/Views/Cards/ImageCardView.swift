//
//  ImageCard.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct ImageCardView: CardType {
    @ObservedObject var cardVM: CardViewModel
    @Environment(\.openURL) var openURL
    private let width: CGFloat
    
    
    init(_ cardVM: CardViewModel, width: CGFloat) {
        self.cardVM = cardVM
        self.width = width
    }
    
    var minHeight: CGFloat {
        (UIScreen.main.bounds.width - (20 * UIScreen.main.scale)) / cardVM.bgAspectRatio
    }
    
    var body: some View {
        Button(action: onTap) {
            HC5BackgroundView(url: cardVM.bgImageUrl, asset: cardVM.bgAsset, aspectRatio: cardVM.bgAspectRatio)
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .frame(alignment: .leading)
        .cornerRadius(10)
        .frame(minHeight: minHeight)
    }
    
    func onTap() {
        if !cardVM.url.isEmpty {
            if let url = URL(string: cardVM.url) {
                openURL(url)
            }
        }
    }
}
