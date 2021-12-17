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
                 HStack {
                     ForEach(cards, id:\.uuid) { cardVM in
                         getCardType(for: cardVM)
//                             .padding()
                     }
                 }
            }.frame(height: 100)
        } else {
            if let firstCard = cards.first {
                getCardType(for: firstCard)
            }
            
        }
    }
    
    
    func getCardType(for cardVM: CardViewModel) -> AnyView {
        switch designType {
            case "HC3": return AnyView(BigDisplayCardView(cardVM))
            case "HC1": return AnyView(SmallDisplayCardView(cardVM))
            default: return AnyView(Text("Hello"))
        }
    }
    
    
    
    
    
}

//struct ContextualCardGroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContextualCardGroupView()
//    }
//}
