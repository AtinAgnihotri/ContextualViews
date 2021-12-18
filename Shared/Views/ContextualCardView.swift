//
//  ContextualCardView.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct ContextualCardView: View {

   @ObservedObject var cardVM: CardViewModel
    
    init(_ cardVM: CardViewModel) {
        self.cardVM = cardVM
    }
    
    var body: some View {
        Text(cardVM.name)
    }
}

//struct ContextualCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContextualCardView()
//    }
//}
