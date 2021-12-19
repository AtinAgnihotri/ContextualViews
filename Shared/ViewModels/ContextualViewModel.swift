//
//  ContextualViewModel.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 18/12/21.
//

import Foundation

class ContextualViewModel {
    private let controller = ContextController.shared
    
    var cardGroups: [CardGroupViewModel] {
        return controller.cardGroups
    }
    
    var isLoading: Bool {
        controller.cardGroups.isEmpty
    }
    
    var errorMessage: String {
        controller.errorMessage
    }
    
    var hasError: Bool {
        !errorMessage.isEmpty
    }
    
    func refresh() {
        controller.refresh()
    }
}
