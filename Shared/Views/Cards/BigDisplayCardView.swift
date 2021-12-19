//
//  BigDisplayCardView.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct BigDisplayCardView: CardType {
    
    @ObservedObject var cardVM: CardViewModel
    @State private var swipeOffset: CGFloat = 0
    @State private var cardOpacity: CGFloat = 1
    @Environment(\.openURL) var openURL
    
    let offsetAmount = UIScreen.main.bounds.width / 3
    
    init(_ cardVM: CardViewModel) {
        self.cardVM = cardVM
    }
    
   
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    SwipeActionButtonView(title: "remind later", imageName: "bell_icon", action: remindLater)
                    Spacer()
                    SwipeActionButtonView(title: "dismiss now", imageName: "dismiss_icon", action: dismiss)
                    Spacer()
                }
                .padding()
                Spacer()
            }
            .background(Color.white)
            .cornerRadius(10)
            ZStack {
                CardBackground(for: cardVM.bgImageUrl, with: cardVM.backgroundColor)
                .onTapGesture {
                    if swipeOffset != 0 {
                        swipeOffset = 0
                    } else {
                        onTap()
                    }
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
            .offset(x: swipeOffset, y: 0)
            
        }
        .animation(.easeInOut(duration: 0.5), value: swipeOffset)
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .frame(height: 400)
        .cornerRadius(10)
        .transition(.slide)
        .onLongPressGesture {
            swipeOffset = swipeOffset == 0 ? offsetAmount : 0
        }
        
    }
    
    func onTap() {
        if !cardVM.url.isEmpty {
            if let url = URL(string: cardVM.url) {
                openURL(url)
            }
        }
    }
    
    func remindLater() {
        ContextualViewController.shared.remindLater(cardVM.name)
    }
    
    func dismiss() {
        ContextualViewController.shared.dismiss(cardVM.name)
    }
}

