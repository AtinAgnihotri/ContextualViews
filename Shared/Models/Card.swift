//
//  Card.swift
//  FamView (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import Foundation



struct Card: Decodable {
    let name: String
    let formattedTitle: FormattedText?
    let title: String?
    let formattedDescription: FormattedText?
    let description: String?
    let icon: CardImage?
    let url: String?
    let bgImage: CardImage?
    let bgColor: String?
    let bgGradient: Gradient?
    let cta: [CallToAction]?
    let height: Int?
}

struct CardGroup: Decodable {
    let id: Int
    let cards: [Card]
    let name: String
    let designType: String
    let isScrollable: Bool
    let height: Double?
}
