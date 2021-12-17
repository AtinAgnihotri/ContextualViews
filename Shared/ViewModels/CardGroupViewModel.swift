//
//  CardGroupViewModel.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import Foundation

class CardGroupViewModel {
    private let cardGroup: CardGroup
    let uuid: UUID
    
    init(_ cardGroup: CardGroup) {
        self.cardGroup = cardGroup
        self.uuid = UUID()
    }
    
    var id: Int {
        cardGroup.id
    }
    
    var name: String {
        cardGroup.name
    }
    
}


