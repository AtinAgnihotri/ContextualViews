//
//  ImageCard.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct ImageCardView: View {
    @ObservedObject var cardVM: CardViewModel
    @Environment(\.openURL) var openURL
    
    
    
    init(_ cardVM: CardViewModel) {
        self.cardVM = cardVM
        
    }
    
    var minHeight: CGFloat {
        (UIScreen.main.bounds.width - (20 * UIScreen.main.scale)) / cardVM.bgAspectRatio
    }
    
    var body: some View {
        Button(action: onTap) {
            HC5Background(url: cardVM.bgImageUrl, asset: cardVM.bgAsset, aspectRatio: cardVM.bgAspectRatio)
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
