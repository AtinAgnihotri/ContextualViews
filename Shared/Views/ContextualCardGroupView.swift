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
            case "HC3": return AnyView(BigDisplayCardView(cardVM))
            case "HC1": return AnyView(SmallDisplayCardView(cardVM, isScrollable: isScrollable))
            case "HC6": return AnyView(SmallDisplayCardView(cardVM, isScrollable: isScrollable, hasChevron: true))
            case "HC9": return AnyView(DynamicWidthCardView(cardVM, with: cardGroupVM.height))
            default: return AnyView(GenericCardType(cardVM))
        }
    }
    
    
    
    
    
}

//struct ContextualCardGroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContextualCardGroupView()
//    }
//}
