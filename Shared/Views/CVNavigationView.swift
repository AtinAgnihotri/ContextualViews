//
//  CVNavigationView.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 18/12/21.
//

import SwiftUI

struct CVNavigationView: View {
    @ObservedObject var controller = ContextController.shared
    var body: some View {
        if controller.didAppLaunch {
            CVLoader()
        } else {
            VStack {
                CVNavBar()
                ContextualView()
            }
        }
    }
}

struct CVNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CVNavigationView()
    }
}
