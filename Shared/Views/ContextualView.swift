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
                    ForEach(contextualVM.cardGroups, id:\.id) {
                        Text($0.name)
                    }
                }.refreshable {
                    contextualVM.refresh()
                }
            }
        }
        
    }
}

struct ContextualView_Previews: PreviewProvider {
    static var previews: some View {
        ContextualView()
    }
}
