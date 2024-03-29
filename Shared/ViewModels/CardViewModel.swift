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
        return Color(hex: "#FFFFFF")
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
    
    var hasBgColor: Bool {
        card.bgColor != nil
    }
    
    var iconUrl: String {
        card.icon?.imageUrl ?? ""
    }
    
    var assetName: String {
        card.icon?.assetType ?? ""
    }
    
    var hasAsset: Bool {
        card.icon?.assetType != nil
    }
    
    var bgAspectRatio: CGFloat {
        CGFloat(card.bgImage?.aspectRatio ?? 1)
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
        var attrString = AttributedString(words.joined(separator: " "))
        for entity in formattedText.entities {
            if let range = attrString.range(of: entity.text) {
                // Handle urls, if any
                if let url = entity.url {
                    attrString[range].link = URL(string: url)
                }
                // Handle colors, if any
                if let color = entity.color {
                    attrString[range].foregroundColor = Color(hex: color)
                }
                // Handle styling, if any
                if let style = entity.fontStyle {
                    if style == "bold" {
                        attrString[range].font = .custom("Roboto-Regular", fixedSize: 14).bold()
                    } else if style == "underline" {
                        attrString[range].underlineStyle = .single
                        if let color = entity.color {
                            attrString[range].underlineColor = UIColor(cgColor: Color(hex: color).cgColor!)
                        } else {
                            attrString[range].underlineColor = .black
                        }
                    } else if style == "italic" {
                        attrString[range].font = .custom("Roboto-Regular", fixedSize: 14).italic()
                    }
                }
                
            }
        }
        return attrString
    }
    
    var bgAsset: String {
        card.bgImage?.assetType ?? ""
    }
    
    
    
}
