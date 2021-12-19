//
//  SwiftUIView.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 18/12/21.
//

import SwiftUI
import CachedAsyncImage

struct HC3Background: View {
    let url: String
    let bgColor: Color
    
    init(for url: String, with bgColor: Color) {
        self.url = url
        self.bgColor = bgColor
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                bgColor
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                bgColor
            @unknown default:
                EmptyView()
            }
        }
    }
}


