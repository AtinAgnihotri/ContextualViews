//
//  ContextualView.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct ContextualView: View {
    @ObservedObject var controller = ContextController.shared
    var contextualVM = ContextualViewModel()
        
    var body: some View {
        if contextualVM.hasError {
            VStack {
                Spacer()
                Text(contextualVM.errorMessage)
                    .font(.title3)
                    .padding()
                Button(action: contextualVM.refresh) {
                    Text("Refresh")
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()
            }
        } else if contextualVM.cardGroups.isEmpty {
            VStack {
                Spacer()
                CVLoader()
                Spacer()
            }
        } else {
            List {
                ForEach(contextualVM.cardGroups, id:\.uuid) { cardGroup in
                        ContextualCardGroup(cardGroup)
                            .listRowInsets(EdgeInsets())
                            .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                            .frame(minHeight: getMinHeight(for: cardGroup))
                            .padding(.vertical, 10)
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .shadow(radius: 25)
            .padding(.top, 20)
            .padding(.leading, 20)
            .listStyle(PlainListStyle())
            .listSeparatorStyle(style: .none)
            .refreshable {
                contextualVM.refresh()
            }
            .frame(maxWidth: .infinity)
            .edgesIgnoringSafeArea(.trailing)
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
}

struct ContextualView_Previews: PreviewProvider {
    static var previews: some View {
        ContextualView()
    }
}
