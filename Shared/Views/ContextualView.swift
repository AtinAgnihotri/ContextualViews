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
                            .shadow(radius: 25)
                            .frame(minHeight: $0.height)
                            .padding(.vertical, $0.height == 0 ? 0 : 10)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
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
