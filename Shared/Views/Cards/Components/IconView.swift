//
//  IconView.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 18/12/21.
//

import SwiftUI
import CachedAsyncImage

public enum IconShape {
    case cirlce
    case roundedRectancle
}

struct AsyncIcon: View {
    private let url: String
    private let shape: IconShape
    
    init(url: String, shape: IconShape = .cirlce) {
        self.url = url
        self.shape = shape
        print("icon", "async", url)
    }
    
    var body: some View {
        CachedAsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                Image("icon_loading")
                    .icon(shape: shape)
            case .success(let image):
                image
                    .icon(shape: shape)
                    .onAppear {
                        print("icon", url, image)
                    }
            case .failure:
                Image("icon_loading")
                    .icon(shape: shape)
            @unknown default:
                Image("icon_loading")
                    .icon(shape: shape)
            }
        }
    }
}

struct IconView: View {
    
    private let url: String
    private let hasAsset: Bool
    private let asset: String
    private let shape: IconShape
    
    init(url: String, asset: String, hasAsset: Bool, shape: IconShape = .cirlce) {
        self.url = url
        self.asset = asset
        self.hasAsset = hasAsset
        self.shape = shape
    }
    
    var body: some View {
        if hasAsset {
            Image(asset)
                .icon(shape: shape)
        } else {
            AsyncIcon(url: url, shape: shape)
                
        }
    }
}

