//
//  ContextualView.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct ContextualView: View {
    @ObservedObject var controller = ContextualViewController.shared
    var contextualVM = ContextualViewModel()
    
    init() {
        
    }
        
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
                        ContextualCardGroupView(cardGroup)
                            .listRowInsets(EdgeInsets())
                            .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                            .frame(minHeight: getMinHeight(for: cardGroup))

                            .padding(.vertical, cardGroup.designType == "HC9" ? 15 : 0)
                            .padding(.bottom, cardGroup.designType == "HC5" ? 10 : 0)
//                            .padding(.vertical, ["HC9", "HC5"].contains(cardGroup.designType) ? 15 : 0)
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
    
    func getTopSpacerMinLength(for i: Int) -> CGFloat {
        if i == 0 {
            return 0
        }
        let prevDesignType = contextualVM.cardGroups[i - 1].designType
        if ["HC5", "HC9" ].contains(prevDesignType) {
            return 10
        }
        return 5
    }
    
    func getBottomSpacerMinLength(for i: Int) -> CGFloat {
        if i == contextualVM.cardGroups.count - 1 {
            return 0
        }
        let nextDesignType = contextualVM.cardGroups[i + 1].designType
        if ["HC5", "HC9" ].contains(nextDesignType) {
            return 20
        }
        return 10
    }
    
    func getMinHeight(for cardGroup: CardGroupViewModel) -> CGFloat {
        if cardGroup.height != 0 {
            return CGFloat(cardGroup.height) + 10
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
