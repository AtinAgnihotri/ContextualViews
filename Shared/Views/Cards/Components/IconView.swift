//
//  IconView.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 18/12/21.
//

import SwiftUI

struct AsyncIcon: View {
    private let url: String
    
    init(url: String) {
        self.url = url
        print("icon", "async", url)
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                Image("icon_loading")
                    .icon()
            case .success(let image):
                image
                    .icon()
                    .onAppear {
                        print("icon", url, image)
                    }
            case .failure:
                Image("icon_loading")
                    .icon()
            @unknown default:
                Image("icon_loading")
                    .icon()
            }
        }
    }
}

struct IconView: View {
    private let url: String
    private let hasAsset: Bool
    private let asset: String
    
    init(url: String, asset: String, hasAsset: Bool) {
        self.url = url
        self.asset = asset
        self.hasAsset = hasAsset
    }
    
    var body: some View {
        
        if hasAsset {
            Image(asset)
                .icon()
        } else {
            AsyncIcon(url: url)
        }
    }
}

//struct IconView_Previews: PreviewProvider {
//    static var previews: some View {
//        IconView()
//    }
//}
