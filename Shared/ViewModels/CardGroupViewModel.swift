//
//  CardGroupViewModel.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

class CardGroupViewModel: ObservableObject {
    private let cardGroup: CardGroup
    let cards: [CardViewModel]
    let uuid: UUID
    
    init(_ cardGroup: CardGroup) {
        self.cardGroup = cardGroup
        self.cards = cardGroup.cards.map { CardViewModel($0) }
        self.uuid = UUID()
    }
    
    var id: Int {
        cardGroup.id
    }
    
    var name: String {
        cardGroup.name
    }
    
    var isScrollable: Bool {
        cardGroup.isScrollable
    }
    
    var designType: String {
        cardGroup.designType
    }
    
    var height: Double {
        (cardGroup.height ?? 0) * Double(UIScreen.main.scale)
    }
    
    
}


