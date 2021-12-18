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
                    Button(action: remindLater) {
                        VStack {
                            Image("bell_icon")
                                .fitToView()
                                .frame(width: 30)
                                .padding(.top)
                            Text("remind later")
                                .padding(.bottom)
                                .padding(.horizontal, 5)
                        }
                        .background(Color(hex: "#F7F6F3"))
                        .cornerRadius(5)
                    }
                    Spacer()
                    Button(action: dismiss) {
                        VStack {
                            Image("dismiss_icon")
                                .fitToView()
                                .frame(width: 30)
                                .padding(.top)
                            Text("dismiss now")
                                .padding(.bottom)
                                .padding(.horizontal, 5)
                        }
                        .background(Color(hex: "#F7F6F3"))
                        .cornerRadius(5)
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
            .background(Color.white)
            .cornerRadius(10)
            ZStack {
//                Button(action: onTap) {
                    CardBackground(for: cardVM.bgImageUrl, with: cardVM.backgroundColor)
//                }
                .onTapGesture {
                    onTap()
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
            .animation(.easeInOut(duration: 0.5), value: swipeOffset)
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .frame(height: 400)
        .cornerRadius(10)
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

