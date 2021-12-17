//
//  CardsViewModel.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import SwiftUI

class CardViewModel: ObservableObject {
    
    private let card: Card
    let cta: [CTAViewModel]
    let uuid: UUID
    
    init(_ card: Card) {
        self.card = card
        self.uuid = UUID()
        if let cta = card.cta {
            self.cta = cta.map { CTAViewModel($0) }
        } else {
            self.cta = [CTAViewModel]()
        }
    }
    
    var name: String {
        card.name
    }
    
    var title: AttributedString {
        let text: AttributedString
        if let formattedTitle = card.formattedTitle {
            text = getFormattedString(formattedTitle)
        } else {
            text = AttributedString(card.title ?? "Card Title")
        }
        return text
    }
    
    var description: AttributedString {
        let text: AttributedString
        if let formattedDescription = card.formattedDescription {
            text = getFormattedString(formattedDescription)
        } else {
            text = AttributedString(card.description ?? "Card Description")
        }
        return text
    }
    
    var backgroundColor: Color {
        if let bgColor = card.bgColor {
            return Color(hex: bgColor)
        }
        return .clear
    }
    
    var bgImageUrl: String {
        card.bgImage?.imageUrl ?? ""
    }
    
    var url: String {
        card.url ?? ""
    }
    
    var hasCTA: Bool {
        !cta.isEmpty
    }
    
    private func getFormattedString(_ formattedText: FormattedText) -> AttributedString {
        var words = formattedText.text.components(separatedBy: " ")
        let attrWords = formattedText.entities.map { $0.text }
        let attrCount = attrWords.count
        let wordCount = words.count
        var ac = 0
        var wc = 0
        while (ac < attrCount && wc < wordCount) {
            if (words[wc].contains("{}")) {
                words[wc] = words[wc].replacingOccurrences(of: "{}", with: attrWords[ac])
                ac += 1
            }
            wc += 1
        }
        print(words)
        print(attrWords)
        print(attrCount, ac)
        print(wordCount, wc)
        var attrString = AttributedString(words.joined(separator: " "))
        for entity in formattedText.entities {
            if let range = attrString.range(of: entity.text) {
                if let url = entity.url {
                    attrString[range].link = URL(string: url)
                }
                if let color = entity.color {
                    attrString[range].foregroundColor = Color(hex: color)
                }
                // MARK: TODO Set font styles
            }
        }
        return attrString
    }
    
}
