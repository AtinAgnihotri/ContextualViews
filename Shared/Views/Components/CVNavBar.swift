//
//  FamPayNavBar.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 18/12/21.
//

import SwiftUI

struct CVNavBar: View {
    var body: some View {
        HStack {
            Text("fampay")
                .font(Font.custom("Roboto-Regular", size: 20).bold())
                .bold()
            Image("fp_icon")
                .padding(.horizontal, -10)
        }
        .background(Color.white)
    }
}

struct FamPayNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CVNavBar()
    }
}
