//
//  ContextualViewModel.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 17/12/21.
//

import Foundation

class ContextualViewModel: ObservableObject {
    
    @Published var cardGroups: [CardGroupViewModel]
    
    var isLoading: Bool {
        cardGroups.isEmpty
    }
    
    init() {
        cardGroups = [CardGroupViewModel]()
        refresh()
    }
    
    func refresh() {
        print("Refreshing List")
        WebService.shared.fetchHomepageConfig { [weak self] result in
            switch result {
            case .success(let response):
                
                    self?.cardGroups = response.cardGroups.map {
                        CardGroupViewModel($0)
                    }
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
