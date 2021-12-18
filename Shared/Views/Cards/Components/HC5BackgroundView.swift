//
//  HC5BackgroundView.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 18/12/21.
//

import SwiftUI

struct HC5BackgroundView: View {
    private let url: String
    private let asset: String
    private let aspectRatio: CGFloat
    
    init(url: String, asset: String, aspectRatio: CGFloat) {
        self.url = url
        self.asset = asset
        self.aspectRatio = aspectRatio
        print("hc5", url, asset, aspectRatio)
    }
    
    var imageWidth : CGFloat {
        UIScreen.main.bounds.width - (20 * UIScreen.main.scale)
    }
    
    var imageHeight : CGFloat {
        imageWidth / aspectRatio
    }
    
    var Loading: some View {
        HStack {
            Image("fp_icon")
//                .resizable()
//                .aspectRatio(aspectRatio, contentMode: .fit)
//                .fillInView()
                .resizable()
                .frame(width: imageWidth, height: imageHeight)
//                .aspectRatio(aspectRatio, contentMode: .fit)

        }.background(Color.random())
    }
    
    var body: some View {
        
        if asset.isEmpty {
            AsyncImage(url: URL(string: url)) { phase in
                switch phase {
                case .empty:
                    Loading
                case .success(let image):
                    image
//                        .aspectRatio(aspectRatio, contentMode: .fill)
//                        .fillInView()
                        .resizable()
                        .frame(width: imageWidth, height: imageHeight)
//                        .aspectRatio(aspectRatio, contentMode: .fit)

                case .failure:
                    Loading
                @unknown default:
                    Loading
                }
            }
            
        } else {
            Image(asset)
                .resizable()
                .frame(width: imageWidth, height: imageHeight)
        }
       
    }
}


