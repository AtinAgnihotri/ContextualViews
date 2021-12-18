//
//  SmallDisplayCardView.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct SmallDisplayCardView: CardType {
    
    @ObservedObject var cardVM: CardViewModel
    private let inScrollableStack: Bool
    @Environment(\.openURL) var openURL
    
    init(_ cardVM: CardViewModel, isScrollable: Bool = false) {
        self.cardVM = cardVM
        inScrollableStack = isScrollable
        print("Small Card in Scrollable Stack:", cardVM.iconUrl, cardVM.hasAsset)
    }
    
   
    var body: some View {
        ZStack {
            Button(action: onTap) {
                cardVM.hasBgColor ? cardVM.backgroundColor : Color(hex: "#FBAF03")
            }
            HStack {
                IconView(url: cardVM.iconUrl, asset: cardVM.assetName, hasAsset: cardVM.hasAsset)
                    .padding()
                VStack (alignment: .leading) {
                    Text(cardVM.title)
                        .font(Font.custom("Roboto", size: 14))
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                    Text(cardVM.description)
                        .font(Font.custom("Roboto", size: 12))
                        .fontWeight(.thin)
                        .padding(.horizontal, 10)
                }
                if inScrollableStack {
                    Spacer(minLength: 100)
                }
            }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .cornerRadius(10)
        .shadow(radius: 25)
    }
    
    func onTap() {
        if !cardVM.url.isEmpty {
            if let url = URL(string: cardVM.url) {
                openURL(url)
            }
        }
    }
}

