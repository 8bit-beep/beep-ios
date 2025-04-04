//
//  HapticManager.swift
//  beep
//
//  Created by cher1shRXD on 4/4/25.
//

import UIKit


class HapticManager {
    static let instance = HapticManager()
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
