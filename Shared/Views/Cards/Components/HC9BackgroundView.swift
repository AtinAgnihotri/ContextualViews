//
//  HC9BackgroundView.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 18/12/21.
//

import SwiftUI
import CachedAsyncImage

struct HC9BackgroundView: View {
    private let url: String
    private let asset: String
    
    init(url: String, asset: String) {
        self.url = url
        self.asset = asset
        print("bg", url, asset)
    }
    
    var Loading: some View {
        HStack {
            Image("fp_icon")
                .fitToView()
        }.background(Color.random())
    }
    
    var body: some View {
        if asset.isEmpty {
            CachedAsyncImage(url: URL(string: url)) { phase in
                switch phase {
                case .empty:
                    Loading
                case .success(let image):
                    image.fitToView()
                case .failure:
                    Loading
                @unknown default:
                    Loading
                }
            }
            
        } else {
            Image(asset)
                .fitToView()
        }
    }
}

