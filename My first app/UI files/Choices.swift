//
//  Choices.swift
//  My first app
//
//  Created by Jashnoor Singh on 16/06/26.
//

import SwiftUI

struct Choices: View {
    let game : CodeBreaker
    var body: some View {
        HStack{
            ForEach(game.pegChoices.indices, id: \.self){ index in
                PegView(peg: game.pegChoices[index])
            }
        }
    }
}

//#Preview {
//    Choices()
//}
