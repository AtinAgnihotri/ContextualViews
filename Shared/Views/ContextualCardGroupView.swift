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
            }
            .frame(maxHeight: cardGroupVM.height == 0 ? .infinity : cardGroupVM.height)
        } else {
            drawCards()
                .padding(.trailing, 20)
        }
    }
    
    func drawCards() -> some View {
        HStack {
            ForEach(cards, id:\.uuid) { cardVM in
                getCardType(for: cardVM)
            }
        }
    }
    
    func getCardType(for cardVM: CardViewModel) -> AnyView {
        switch designType {
            case "HC3": return AnyView(BigDisplayCard(cardVM))
            case "HC1": return AnyView(SmallDisplayCard(cardVM, isScrollable: isScrollable))
            case "HC6": return AnyView(SmallDisplayCard(cardVM, isScrollable: isScrollable, hasChevron: true))
            case "HC9": return AnyView(DynamicWidthCard(cardVM, with: cardGroupVM.height).padding(.vertical))
            case "HC5": return AnyView(ImageCardView(cardVM))
            default: return AnyView(GenericCard(cardVM))
        }
    }
    
}
