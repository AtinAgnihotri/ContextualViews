//
//  ContextualView.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct ContextualView: View {
    @ObservedObject var contextualVM = ContextualViewModel()
    
    init() {
//        UITableView.appearance().separatorStyle = .none
//        UITableViewCell.appearance().backgroundColor = .green
//        UITableView.appearance().backgroundColor = .green
    }
        
    var body: some View {
        ZStack {
            if contextualVM.isLoading {
                Text("Loading . . .")
            } else {
                List {
                    ForEach(contextualVM.cardGroups, id:\.uuid) {
                        ContextualCardGroupView($0)
                            .listRowInsets(EdgeInsets())
                            
                            .frame(minHeight: getMinHeight(for: $0))
                            .padding(.vertical, getPadding(for: $0))
                    }
                    .shadow(radius: 25)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .edgesIgnoringSafeArea(.horizontal)
                .listSeparatorStyle(style: .none)
                .refreshable {
                    contextualVM.refresh()
                }
                .frame(maxWidth: .infinity)
            }
        }
        
    }
    
    func getMinHeight(for cardGroup: CardGroupViewModel) -> CGFloat {
        if cardGroup.height != 0 {
            return CGFloat(cardGroup.height)
        } else if cardGroup.designType == "HC5" {
            var maxHeight: CGFloat = 0
            for card in cardGroup.cards {
                let height = (UIScreen.main.bounds.width - (20 * UIScreen.main.scale)) / card.bgAspectRatio
                if height > maxHeight {
                    maxHeight = height
                }
            }
            return maxHeight
        }
        return 0
    }
    
    func getPadding(for cardGroup: CardGroupViewModel) -> CGFloat {
        if cardGroup.height != 0 || ["HC5", "HC9"].contains(cardGroup.designType) {
//        if cardGroup.height != 0 {
            return 10
        }
        return 0
    }
}

struct ContextualView_Previews: PreviewProvider {
    static var previews: some View {
        ContextualView()
    }
}
