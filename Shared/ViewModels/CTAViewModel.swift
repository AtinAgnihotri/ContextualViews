//
//  CTAViewModel.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 18/12/21.
//

import Foundation
import SwiftUI

class CTAViewModel: ObservableObject {
    private let cta: CallToAction
    let uuid: UUID
    
    init(_ cta: CallToAction) {
        self.cta = cta
        self.uuid = UUID()
    }
    
    var text: String {
        cta.text
    }
    
    var url: String {
        cta.url ?? ""
    }
    
    var bgColor: String {
        cta.bgColor ?? "#000000"
    }
    
    var textColor: String {
        cta.textColor ?? "#FFFFFF"
    }
}
