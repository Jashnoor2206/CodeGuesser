//
//  Color+String.swift
//  My first app
//
//  Created by Jashnoor Singh on 22/06/26.
//

import SwiftUI
import UIKit

extension Color {
    /// Converts this Color into a plain-text string, suitable for storing
    /// in a SwiftData-backed String property.
    var toString: String {
        let uiColor = UIColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        return "\(r),\(g),\(b),\(a)"
    }

    /// Rebuilds a Color from a string previously produced by `toString`.
    /// Returns nil if the string doesn't match the expected format.
    init?(string: String) {
        let parts = string.split(separator: ",").compactMap { Double($0) }
        guard parts.count == 4 else { return nil }
        self = Color(red: parts[0], green: parts[1], blue: parts[2], opacity: parts[3])
    }

    // below lines allow us to print color names like before

    private static let namedColors: [String: Color] = [
        "red": .red, "blue": .blue, "green": .green, "yellow": .yellow,
        "orange": .orange, "purple": .purple, "pink": .pink, "brown": .brown,
        "black": .black, "white": .white, "gray": .gray, "cyan": .cyan,
        "indigo": .indigo, "mint": .mint, "teal": .teal, "clear": .clear
    ]

    var rgbaComponents: (CGFloat, CGFloat, CGFloat, CGFloat) {
        let uiColor = UIColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }

    var debugName: String {
        let (r1, g1, b1, a1) = self.rgbaComponents
        for (name, color) in Color.namedColors {
            let (r2, g2, b2, a2) = color.rgbaComponents
            if abs(r1 - r2) < 0.01, abs(g1 - g2) < 0.01,
               abs(b1 - b2) < 0.01, abs(a1 - a2) < 0.01 {
                return name
            }
        }
        return self.toString
    }
    
    func isApproximately(_ other: Color) -> Bool {
        let (r1, g1, b1, a1) = self.rgbaComponents
        let (r2, g2, b2, a2) = other.rgbaComponents
        return abs(r1 - r2) < 0.01 && abs(g1 - g2) < 0.01 &&
               abs(b1 - b2) < 0.01 && abs(a1 - a2) < 0.01
    }
}

extension Array where Element == Color {
    func isApproximately(_ other: [Color]) -> Bool {
        guard count == other.count else { return false }
        return zip(self, other).allSatisfy { $0.isApproximately($1) }
    }
}
