//
//  Pegchooser.swift
//  My first app
//
//  Created by Jashnoor Singh on 07/06/26.
//

import SwiftUI

struct Pegchooser: View {
    @Binding var selection: Int
    @Binding var game: CodeBreaker
    let attemptsNumber: Int
    var body: some View {
        HStack{
            if !game.isOver{
                if attemptsNumber >= 5{
                    Text("You have exhausted all your attempts")
                        .font(.largeTitle)
                        .animation(.guess, value: attemptsNumber)
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
                    .animation(.guess)
            }
        }
    }
}

//#Preview {
//    Pegchooser()
//}
