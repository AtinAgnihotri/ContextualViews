//
//  CardItems.swift
//  ContextualViews (iOS)
//
//  Created by Atin Aganihotri on 17/12/21.
//

import Foundation

struct Entity: Decodable {
    let text: String
    let color: String?
    let url: String?
    let fontStyle: String?
}

struct FormattedText: Decodable {
    let text: String
    let entities: [Entity]
}

struct CardImage: Decodable {
    let imageType: String
    let assetType: String?
    let imageUrl: String?
    let aspectRatio: Double?
}

struct Gradient: Decodable {
    let colors: [String]
    let angle: Int?
}

struct CallToAction: Decodable {
    let text: String
    let bgColor: String?
    let textColor: String?
    let url: String?
}
