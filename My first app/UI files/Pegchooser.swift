//
//  Pegchooser.swift
//  My first app
//
//  Created by Jashnoor Singh on 07/06/26.
//

import SwiftUI

struct Pegchooser: View {
    @Binding var selection: Int
    let isOver: Bool
    let game: CodeBreaker
    let attemptsNumber: Int
    var body: some View {
        HStack{
            if !isOver{
                if attemptsNumber >= 5{
                    Text("You have exhausted all your attempts")
                        .font(.largeTitle)
                }
                else{
                    ForEach(game.pegChoices, id: \.self){ peg in
                        Button{
                            game.setGuesspeg(peg, at: selection)
                            selection = (selection + 1) % game.MasterCode.pegs.count
                        }label: { PegView(peg: peg) }
                    }.transition(.pegchooser)
                }
            }
            else{
                Text("Congrats you won the game !!")
                    .font(.largeTitle)
            }
        }
    }
}

//#Preview {
//    Pegchooser()
//}
