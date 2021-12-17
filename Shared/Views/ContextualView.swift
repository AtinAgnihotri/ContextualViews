//
//  ContextualView.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

struct ContextualView: View {
    @ObservedObject var contextualVM = ContextualViewModel()
        
    var body: some View {
        ZStack {
            if contextualVM.isLoading {
                Text("Loading . . .")
            } else {
                List {
                    ForEach(contextualVM.cardGroups, id:\.uuid) {
                        ContextualCardGroupView($0)
                            .listRowInsets(EdgeInsets())
                            .padding(.vertical)
                    }
                }
                .listSeparatorStyle(style: .none)
                .refreshable {
                    contextualVM.refresh()
                }
                .frame(maxWidth: .infinity)
            }
        }
        
    }
}

struct ContextualView_Previews: PreviewProvider {
    static var previews: some View {
        ContextualView()
    }
}
