//
//  BigCardSwipeDrawer.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 19/12/21.
//

import SwiftUI

struct SwipeDrawer: View {
    
    let remindLater: () -> Void
    let dismiss: () -> Void
    
    init(onRemindLater: @escaping () -> Void, onDismissNow: @escaping () -> Void) {
        remindLater = onRemindLater
        dismiss = onDismissNow
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                SwipeDrawerButton(title: "remind later", imageName: "bell_icon", action: remindLater)
                Spacer()
                SwipeDrawerButton(title: "dismiss now", imageName: "dismiss_icon", action: dismiss)
                Spacer()
            }
            .padding()
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct SwipeDrawer_Previews: PreviewProvider {
    static let remind = {
        print("Remind Later")
    }
    
    static let dismiss = {
        print("Dismiss Now")
    }
    
    static var previews: some View {
        SwipeDrawer(onRemindLater: remind, onDismissNow: dismiss)
    }
}
