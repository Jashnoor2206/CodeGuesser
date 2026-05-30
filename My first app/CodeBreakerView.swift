//
//  CodeBreakerView.swift
//  My first app
//
//  Created by Jashnoor Singh on 25/05/26.
//

// here we are trying to build the game in which we have to guess the 4 colors , we have game master and a player . Game master takes 4 colors but does not show it to the player then player guesses the colors one by one . If player guessed a color and it is on same place in game master's pallete then he gets a black pin. If he guesses the color and it is on game master's pallete but on some other place then he gets white pin. So in limited guesses player has to guess full pallete of game master if he does he wins

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data owned by me
    @State var game = CodeBreaker()
    
    // MARK: -  Body
    var body: some View {
        VStack{ // now for the vstack we will have a mastercode and a guess code
            CodeView(for: game.MasterCode) // master Code
            ScrollView{
                CodeView(for: game.guess) // guess code
                ForEach(game.attempts.indices.reversed(), id: \.self){
                    index in CodeView(for: game.attempts[index])
                }
            }
        }.padding()
    }
        
        var guessButton: some View{
            Button("Guess"){
                game.attemptGuess()
            }.font(.system(size: 80))
             .minimumScaleFactor(0.1)
        }
    func CodeView(for code: Code) -> some View{
        HStack{
            ForEach(code.pegs.indices, id: \.self){ index in
                PegView(peg: code.pegs[index])
                    .onTapGesture {
                        if(code.kind == .guess){
                            game.ChangeGuessPeg(at: index )
                        }
                    }
                }
            Rectangle()
                .fill(Color.clear)
                .aspectRatio(0.75, contentMode: .fit)
                .overlay{
                    if let match = code.matches{
                        Pins(matches: match) // this is from other file
                    }
                    else{
                        if code.kind == .guess{
                            guessButton
                    }
                }
            }
        }
    }
}

#Preview {
    CodeBreakerView()
}
