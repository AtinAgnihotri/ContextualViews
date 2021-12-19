//
//  CTAView.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 18/12/21.
//

import SwiftUI


struct CTAButton: View {
    @ObservedObject var ctaVM: CTAViewModel
    @Environment(\.openURL) var openURL
    
    init(_ ctaVM: CTAViewModel) {
        self.ctaVM = ctaVM
        print(ctaVM.url)
    }
    
    var body: some View {
        Button(action: onCTATap) {
            Text(ctaVM.text)
                .foregroundColor(Color(hex: ctaVM.textColor))
        }
        .padding()
        .background(Color(hex: ctaVM.bgColor))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
    }
    
    
    func onCTATap() {
        print("\(ctaVM.text) clicked")
        if let url = URL(string: ctaVM.url) {
            openURL(url)
        }
    }
}

