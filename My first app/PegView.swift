//
//  PegView.swift
//  My first app
//
//  Created by Jashnoor Singh on 30/05/26.
// This stores the rounded rectangle that we make

import SwiftUI

struct PegView: View {
    
    // MARK: Data In
    let peg: Peg
    
    // MARK: - Body
    let pegShape = RoundedRectangle(cornerRadius: 10)
    var body: some View {
        pegShape
            .fill(peg)
            .contentShape(Rectangle())
            .aspectRatio(0.75, contentMode: .fit)
    }
}

#Preview {
    PegView(peg: .blue)
}
