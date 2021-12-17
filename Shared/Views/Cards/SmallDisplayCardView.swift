//
//  SmallDisplayCardView.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct SmallDisplayCardView: CardType {
    
    @ObservedObject var cardVM: CardViewModel
    @Environment(\.openURL) var openURL
    
    init(_ cardVM: CardViewModel) {
        self.cardVM = cardVM
        print("Small DisplayCard", cardVM)
    }
    
   
    var body: some View {
       
            ZStack {
                Button(action: onTap) {
                    Color(hex: "#FBAF03")
                }
                HStack {
                    
                    
                    VStack (alignment: .leading) {
                        Text(cardVM.title)
                            .font(Font.custom("Roboto", size: 14))
                            .fontWeight(.semibold)
                            .padding(.vertical)
                            .padding(.horizontal, 10)
                        Text(cardVM.description)
                            .font(Font.custom("Roboto", size: 14))
                            .fontWeight(.regular)
                            .padding(.vertical)
                            .padding(.horizontal, 10)
                    }
                        
                    
//                    VStack (alignment: .leading){
//                        Text(cardVM.title)
//                            .font(Font.custom("Roboto", size: 30))
//                            .fontWeight(.semibold)
//                            .padding(.vertical)
//                            .padding(.horizontal, 10)
//
//                        Text(cardVM.description)
//                            .padding()
//                        if (cardVM.hasCTA) {
//                            ForEach(cardVM.cta, id:\.uuid) {
//                                CTAView($0)
//                            }
//                        }
//                    }
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
//
//struct SmallDisplayCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        SmallDisplayCardView()
//    }
//}
