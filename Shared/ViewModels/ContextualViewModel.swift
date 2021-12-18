//
//  ContextualViewModel.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 18/12/21.
//

import Foundation

class ContextualViewModel {
    private let controller = ContextualViewController.shared
    
    init() {
        print("ContextualViewModel was initialized")
    }
    
    var cardGroups: [CardGroupViewModel] {
        print("Dex", controller.cardGroups)
        return controller.cardGroups
    }
    
    var isLoading: Bool {
        controller.cardGroups.isEmpty
    }
    
    func refresh() {
        controller.refresh()
    }
}
