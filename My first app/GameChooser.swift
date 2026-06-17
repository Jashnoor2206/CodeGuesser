//
//  GameChooser.swift
//  My first app
//
//  Created by Jashnoor Singh on 16/06/26.
//

import SwiftUI

struct GameChooser: View {
    @State private var games : [CodeBreaker] = []
    var body: some View {
        NavigationStack{
            List($games, id: \.pegChoices){ $game in
                NavigationLink{
                    CodeBreakerView(game: $game)
                }label:{
                    VStack(alignment: .leading){
                        Text(game.name).font(.title)
                        Choices(game: game)
                            .frame(maxHeight: 80)
                        Text("^[\(game.attempts.count) attempt](inflect: true)")
                            .font(.title3)
                    }
                }
            }.listStyle(.automatic)
        }.onAppear(){
                games.append(CodeBreaker(name: "MasterMind", pegChoices : [.red, .blue, .green, .yellow]))
                games.append(CodeBreaker(name: "Earth Tones", pegChoices : [.brown, .orange, .black, .yellow, .green]))
                games.append(CodeBreaker(name: "Aqua Tones", pegChoices : [.blue, .cyan, .indigo]))
        }
    }
}

#Preview {
    GameChooser()
}
