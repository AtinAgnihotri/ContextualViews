//
//  SmallDisplayCardView.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct SmallDisplayCard: View {
    
    @ObservedObject var cardVM: CardViewModel
    private let inScrollableStack: Bool
    private let hasChevron: Bool
    @Environment(\.openURL) var openURL
    
    let minWidth : CGFloat = UIScreen.main.bounds.width - (20 * UIScreen.main.scale)
    
    
    init(_ cardVM: CardViewModel, isScrollable: Bool = false, hasChevron: Bool = false) {
        self.cardVM = cardVM
        inScrollableStack = isScrollable
        self.hasChevron = hasChevron
    }
    
   
    var body: some View {
        ZStack {
            Button(action: onTap) {
                cardVM.hasBgColor ? cardVM.backgroundColor : Color(hex: "#FBAF03")
            }
            HStack {
                SmallDisplayIcon(url: cardVM.iconUrl, asset: cardVM.assetName, hasAsset: cardVM.hasAsset, shape: hasChevron ? .roundedRectancle : .cirlce)
                    .padding()
                VStack (alignment: .leading) {
                    Text(cardVM.title)
//                        .font(Font.custom("Roboto-Medium", size: 14))
                        .font(Font.system(size: 14))
                        .fontWeight(.semibold)
                        .padding(.horizontal, 5)
                    Text(cardVM.description)
                        .font(Font.system(size: 14))
                        .fontWeight(.regular)
                        .padding(.horizontal, 5)
                }
                if inScrollableStack {
                    Spacer(minLength: 100)
                    if hasChevron {
                        Image(systemName: "chevron.right")
                            .icon()
                            .padding()
                    }
                } else if hasChevron {
                    Spacer()
                    Image(systemName: "chevron.right")
                        .icon()
                        .padding()
                }
            }
        }
        .buttonStyle(.plain)
        .frame(minWidth: inScrollableStack ? minWidth : 0)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .cornerRadius(10)
    }
    
    func onTap() {
        if !cardVM.url.isEmpty {
            if let url = URL(string: cardVM.url) {
                openURL(url)
            }
        }
    }
}

