//
//  CodeBreakerView.swift
//  My first app
//
//  Created by Jashnoor Singh on 25/05/26.
//

// here we are trying to build the game in which we have to guess the 4 colors , we have game master and a player . Game master takes 4 colors but does not show it to the player then player guesses the colors one by one . If player guessed a color and it is on same place in game master's pallete then he gets a black pin. If he guesses the color and it is on game master's pallete but on some other place then he gets white pin. So in limited guesses player has to guess full pallete of game master if he does he wins

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data shared to me
    @Binding var game: CodeBreaker

    // MARK: Data owned by me
    @State private var attemptsNumber: Int = 0
    @State private var selection: Int = 0
    @State private var restarting: Bool = false
    @State private var PinsHidden: Bool = false
    
    // MARK: -  Body
    var body: some View {
        VStack{ // now for the vstack we will have a mastercode and a guess code
            CodeView(code: game.MasterCode){restartButton}// master Code
            ScrollView{
                    if !game.isOver{
                        CodeView(code: game.guess, selection: $selection){guessButton} // guess code
                            .opacity(restarting ? 0 : 1)
                    }
                    ForEach(game.attempts, id: \.pegs){ attempt in
                        CodeView(code: attempt){
                            if let matches = attempt.matches{
                                Pins(matches: matches)
                                    .opacity(game.attempts.first?.matches == attempt.matches && PinsHidden ? 0 : 1)
                            }
                        }
                    }.transition(.attempts(game.isOver))
                }
            Pegchooser(selection: $selection, game: $game, attemptsNumber: attemptsNumber)
        }.padding()
    }
    
    var guessButton: some View{
        Button("Guess"){
            withAnimation(.guess){
                PinsHidden = true
                game.attemptGuess()
                selection = 0
                game.guess.pegs = Array(repeating: Color.clear, count: 4)
                attemptsNumber = attemptsNumber + 1
            }completion: {
                withAnimation(.guess){ PinsHidden = false }
            }
        }.font(.system(size: 80))
         .minimumScaleFactor(0.1)
    }
    
    var restartButton: some View{
            Button("Restart"){
                withAnimation(.restart){
                    restarting = game.isOver
                    game.restart()
                    selection = 0
                    attemptsNumber = 0
                }completion: {
                    withAnimation(.restart){ restarting = false }
                }

        }.font(.system(size: 80))
            .minimumScaleFactor(0.1)
    }
}

extension AnyTransition{
    static let pegchooser = offset(x: 0, y: 200)
    static func attempts(_ isOver: Bool) -> AnyTransition{
        AnyTransition.asymmetric(
            insertion: .move(edge: .top),
            removal: .move(edge: .trailing))
    }
}
extension Animation{
    static let guess = Animation.default
    static let restart = Animation.default
}


#Preview {
    @Previewable @State var game = CodeBreaker()
    CodeBreakerView(game: $game)
}
