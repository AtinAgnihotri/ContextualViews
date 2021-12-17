//
//  Card.swift
//  FamView (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import Foundation



struct CardIcon: Codable {
    // do codingkeys
    
    let imageType: String
    let imageUrl: String? // AsyncImage(url: URL(string: "https://your_image_url_address"))
    let assetType: String
}

struct DescriptionEntity: Codable { // Entity
    // do codingkeys
    
    let text: String
    let color: String?
    let url: String?
    let fontStyle: String?
}

struct FormattedDescription: Codable { // Formatted Text
    let text: String
    let entities: [DescriptionEntity]
}

struct Card: Codable {
    
    // do codingkeys
    
    let name: String
    let title: String
    let formattedTitle: FormattedDescription
    let icon: CardIcon
    let url: String
    
    
}

struct CardGroup: Decodable {
    let id: Int
    let name: String
    let designType: String
    let isScrollable: Bool
}
