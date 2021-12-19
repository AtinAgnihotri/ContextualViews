//
//  ContextualCardGroupView.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct ContextualCardGroupView: View {
    
    @ObservedObject private var cardGroupVM: CardGroupViewModel
    
    var isScrollable: Bool {
        return cardGroupVM.isScrollable
    }
    
    var cards: [CardViewModel] {
        cardGroupVM.cards
    }
    
    var designType: String {
        cardGroupVM.designType
    }
    
    
    init(_ cardGroupVM: CardGroupViewModel) {
        self.cardGroupVM = cardGroupVM
    }
    
    var body: some View {
        if isScrollable {
            ScrollView (.horizontal, showsIndicators: false) {
                drawCards()
            }.frame(height: 100)
        } else {
            drawCards()
                .padding(.trailing, 20)
        }
    }
    
    
    func drawCards() -> some View {
    
            HStack {
                ForEach(cards, id:\.uuid) { cardVM in
                    getCardType(for: cardVM, width: 0)
                }
            }
            
            
    }
    
    func getVerticalPading(for designType: String) -> CGFloat {
        return designType == "HC9" ? 100 : 0
    }
    
    
    func getCardType(for cardVM: CardViewModel, width: CGFloat) -> AnyView {
        switch designType {
            case "HC3": return AnyView(BigDisplayCardView(cardVM))
            case "HC1": return AnyView(SmallDisplayCardView(cardVM, isScrollable: isScrollable))
            case "HC6": return AnyView(SmallDisplayCardView(cardVM, isScrollable: isScrollable, hasChevron: true))
            case "HC9": return AnyView(DynamicWidthCardView(cardVM, with: cardGroupVM.height).padding(.vertical))
            case "HC5": return AnyView(ImageCardView(cardVM, width: width - 10))
//                                        .padding(.vertical))
            default: return AnyView(GenericCardType(cardVM))
        }
    }
    
}
