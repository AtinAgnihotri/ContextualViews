//
//  CVLoader.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 19/12/21.
//

import SwiftUI

struct CVLoader: View {
    @State private var animationAmount = 0.0
    var animation: Animation {
        Animation.linear
        .repeatForever(autoreverses: false)
    }

    var body: some View {
        Image("fp_icon")
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
            .scaleEffect(2)
            .onAppear {
                withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                    animationAmount += 360
                }
            }
    }
}

struct CVLoader_Previews: PreviewProvider {
    static var previews: some View {
        CVLoader()
    }
}
