//
//  CustomViewModifiers.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 18/12/21.
//

import SwiftUI

struct ListSeparatorStyle: ViewModifier {
    
    let style: UITableViewCell.SeparatorStyle
    
    func body(content: Content) -> some View {
        content
            .onAppear() {
                UITableView.appearance().separatorStyle = self.style
            }
    }
}

extension View {
    
    func listSeparatorStyle(style: UITableViewCell.SeparatorStyle) -> some View {
        ModifiedContent(content: self, modifier: ListSeparatorStyle(style: style))
    }
}

extension Image {
    
    func fitToView() -> some View {
        self.resizable().scaledToFit()
    }
    
    func fillInView() -> some View {
        self.resizable().scaledToFill()
    }
    
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
