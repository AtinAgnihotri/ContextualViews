//
//  GenericCardType.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct GenericCard: View {
    @ObservedObject var cardVM: CardViewModel
    
    init(_ cardVM: CardViewModel) {
        self.cardVM = cardVM
    }
    
    var body: some View {
        Text(cardVM.name)
    }
}
