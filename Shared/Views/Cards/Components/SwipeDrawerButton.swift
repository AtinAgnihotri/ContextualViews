//
//  SwipeActionButtonView.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 19/12/21.
//

import SwiftUI

struct SwipeDrawerButton: View {
    
    let action: () -> Void
    let imageName: String
    let title: String
    
    init(title: String, imageName: String, action: @escaping () -> Void) {
        self.title = title
        self.imageName = imageName
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(imageName)
                    .fitToView()
                    .frame(width: 30)
                    .padding(.top)
                Text(title)
                    .padding(.bottom)
                    .padding(.horizontal, 5)
            }
            .background(Color(hex: "#F7F6F3"))
            .cornerRadius(5)
        }
    }
}

struct SwipeActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeDrawerButton(title: "Context Views", imageName: "fp_icon") {
            print("Hello")
        }
    }
}
