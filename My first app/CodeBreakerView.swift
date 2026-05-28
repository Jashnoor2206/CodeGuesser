//
//  CodeBreakerView.swift
//  My first app
//
//  Created by Jashnoor Singh on 25/05/26.
//

// here we are trying to build the game in which we have to guess the 4 colors , we have game master and a player . Game master takes 4 colors but does not show it to the player then player guesses the colors one by one . If player guessed a color and it is on same place in game master's pallete then he gets a black pin. If he guesses the color and it is on game master's pallete but on some other place then he gets white pin. So in limited guesses player has to guess full pallete of game master if he does he wins

import SwiftUI

struct CodeBreakerView: View {
    @State var game = CodeBreaker()
    var body: some View {
        VStack{ // now for the vstack we will have a mastercode and a guess code
            CodeView(for: game.MasterCode) // master Code
            CodeView(for: game.guess) // guess code
            ForEach(game.attempts.indices, id: \.self){
                index in CodeView(for: game.attempts[index])
            }
            Button("Guess"){
                game.attemptGuess()
            }
        }.padding()
    }
    func CodeView(for code: Code) -> some View{
            HStack{
                ForEach(code.pegs.indices, id: \.self){ index in
                    RoundedRectangle(cornerRadius: 10)
                        .aspectRatio(0.75, contentMode: .fit)
                        .foregroundStyle(code.pegs[index])
                        .onTapGesture {
                            if(code.kind == .guess){
                                game.ChangeGuessPeg(at: index )
                            }
                        }
                }
                Pins(matches: [.exact, .inexact, .nomatch, .exact]) // this is from other file
            }
        }
}

#Preview {
    CodeBreakerView()
}
