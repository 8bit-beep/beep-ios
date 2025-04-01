//
//  Color.swift
//  beep
//
//  Created by cher1shRXD on 3/29/25.
//

import SwiftUI

extension Color {
    static let main = Color(hex: "305B7D")
    static let serveColor = Color(hex: "32A89C")
    static let red = Color(hex: "FF6C6C")
    static let dark = Color(hex: "323A45")
    static let grey = Color(hex: "B7B7B7")
    static let black = Color(hex: "000000")
    static let background = Color(hex: "F6F6F6")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
