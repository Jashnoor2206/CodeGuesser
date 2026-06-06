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
    @State private var game = CodeBreaker()
    @State private var selection: Int = 0
    
    // MARK: -  Body
    var body: some View {
        VStack{ // now for the vstack we will have a mastercode and a guess code
            CodeView(code: game.MasterCode){restartButton}// master Code
            ScrollView{
                if !game.isOver{
                    CodeView(code: game.guess, selection: $selection){guessButton} // guess code
                }
                ForEach(game.attempts.indices.reversed(), id: \.self){ index in
                     CodeView(code: game.attempts[index]){
                        if let matches = game.attempts[index].matches{
                            Pins(matches: matches)
                        }
                    }
                }
            }
            pegChooser
        }.padding()
    }
    
    var pegChooser: some View{ // Bottom choices that are displayed
        HStack{
            ForEach(game.pegChoices, id: \.self){ peg in
                Button{
                    game.setGuesspeg(peg, at: selection)
                    selection = (selection + 1) % game.MasterCode.pegs.count
                }label: { PegView(peg: peg) }
            }
        }
    }
    
    var guessButton: some View{
        Button("Guess"){
            withAnimation(.guess){
                game.attemptGuess()
                selection = 0
                game.guess.pegs = Array(repeating: Color.clear, count: 4)
            }
        }.font(.system(size: 80))
            .minimumScaleFactor(0.1)
    }
    
    var restartButton: some View{
            Button("Restart"){
                withAnimation(.restart){
                    game.restart()
                    selection = 0
                }
        }.font(.system(size: 80))
            .minimumScaleFactor(0.1)
    }
}

extension Animation{
    static let guess = easeInOut(duration: 1)
    static let restart = linear(duration: 1)
}


#Preview {
    CodeBreakerView()
}
