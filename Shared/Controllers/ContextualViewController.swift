//
//  ContextualViewModel.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 17/12/21.
//

import Foundation

class ContextualViewController: ObservableObject {
    
    static let shared = ContextualViewController()
    
    @Published var cardGroups: [CardGroupViewModel] {
        didSet {
            cardGroups.forEach {
                print($0)
            }
        }
    }
    @Published var didAppLaunch = true
    @Published var errorMessage = ""
    @Published var remindLaterCardNames: [String]
    @Published var dismissedCardNames: [String] {
        didSet {
            if let data = try? JSONEncoder().encode(dismissedCardNames) {
                UserDefaults.standard.set(data, forKey: Constants.UserDefaultKeys.DISMISSED_CARDS)
            }
        }
    }
    
    private init() {
        cardGroups = [CardGroupViewModel]()
        remindLaterCardNames = [String]()
        dismissedCardNames = [String]()
        loadDismissedCards()
        refresh()
    }
    
    func loadDismissedCards() {
        if let data = UserDefaults.standard.object(forKey: Constants.UserDefaultKeys.DISMISSED_CARDS) as? Data {
            if let dismissedCards = try? JSONDecoder().decode([String].self, from: data) {
                dismissedCardNames = dismissedCards
                print(dismissedCards)
            }
        }
    }
    
    func refresh() {
        errorMessage = ""
        WebService.shared.fetchHomepageConfig { [weak self] result in
            switch result {
            case .success(let response):
                self?.loadCards(from: response.cardGroups)
                self?.errorMessage = ""
            case .failure(let error):
                print(error)
                self?.errorMessage = self?.getErrorMessage(for: error) ?? "Oops! Something went wrong.\nPlease try again. Just swipe from the top 👆"
            }
            self?.didAppLaunch = false
        }
    }
    
    func loadCards(from cardGroups: [CardGroup]) {
        self.cardGroups.removeAll(keepingCapacity: true)
        cardGroups.forEach { cG in
            let cards = cG.cards.filter { !remindLaterCardNames.contains($0.name) && !dismissedCardNames.contains($0.name) }
            let cardGroup = CardGroup(id: cG.id,
                                      cards: cards,
                                      name: cG.name,
                                      designType: cG.designType,
                                      isScrollable: cG.isScrollable,
                                      height: cG.height)
            self.cardGroups.append(CardGroupViewModel(cardGroup))
        }
        
    }
    
    func remindLater(_ cardName: String) {
        remindLaterCardNames.append(cardName)
        refreshPostDismiss()
    }
    
    func dismiss(_ cardName: String) {
        dismissedCardNames.append(cardName)
        refreshPostDismiss()
    }
    
    // MARK: TODO make it do without network call
    private func refreshPostDismiss() {
        var newCardGroups = [CardGroupViewModel]()
        cardGroups.forEach { cg in
            let cards = cg.cards.filter { !remindLaterCardNames.contains($0.name) && !dismissedCardNames.contains($0.name)
            }
            newCardGroups.append(cg.copyWithNewCards(cards: cards))
        }
        cardGroups = newCardGroups
        
    }
    
    private func getErrorMessage(for error: NetworkError) -> String {
        switch error {
        case .decodingError, .domainError: return "😵 Snap! Looks like something broke on our end. Please try again."
        case .urlError: return "Okay, this should never have made it to production. If you're seeing this, and don't work with us, get ready to collect your bug bounty! 🤑"
        case .serverError: return "😓 It seems our services are down at the moment. Please try again later."
        }
    }
}
