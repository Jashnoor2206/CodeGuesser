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
}
