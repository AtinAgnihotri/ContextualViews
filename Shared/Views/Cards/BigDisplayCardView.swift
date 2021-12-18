//
//  BigDisplayCardView.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct BigDisplayCardView: CardType {
    
    @ObservedObject var cardVM: CardViewModel
    @Environment(\.openURL) var openURL
    
    init(_ cardVM: CardViewModel) {
        self.cardVM = cardVM
    }
    
   
    var body: some View {
        ZStack {
            Button(action: onTap) {
                CardBackground(for: cardVM.bgImageUrl, with: cardVM.backgroundColor)
            }
            HStack (alignment: .bottom) {
                Spacer(minLength: 0)
                VStack (alignment: .leading){
                    Spacer()
                    Text(cardVM.title)
                        .font(Font.custom("Roboto", size: 30))
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .padding(.horizontal, 10)

                    Text(cardVM.description)
                        .padding()
                    if (cardVM.hasCTA) {
                        ForEach(cardVM.cta, id:\.uuid) {
                            CTAView($0)
                        }
                    }
                }
                Spacer(minLength: 0)
            }
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .frame(height: 400)
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

//struct BigDisplayCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        BigDisplayCardView(CardViewModel(Card(name: "Some Card", formattedTitle: nil, title: nil, formattedDescription: nil, icon: nil, url: nil, bgImage: nil, bgColor: nil, bgGradient: nil, cta: nil, height: nil)))
//    }
//}
