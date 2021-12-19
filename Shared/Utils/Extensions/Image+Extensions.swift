//
//  Image+Extensions.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 19/12/21.
//

import SwiftUI

extension Image {
    
    // Fit an image to it's parent view
    func fitToView() -> some View {
        self.resizable().scaledToFit()
    }
    
    // Fill an image in it's parent view
    func fillInView() -> some View {
        self.resizable().scaledToFill()
    }
    
    // Icon modifiers for Small Display Cards
    func icon(shape: IconShape = .cirlce) -> some View {
        switch shape {
        case .cirlce: return AnyView(self
                              .fitToView()
                              .clipShape(Circle()))
        case .roundedRectancle: return AnyView(self
                                        .fitToView()
                                        .clipShape(RoundedRectangle(cornerRadius: 5)))
        }
    }
}
