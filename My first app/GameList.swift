//
//  SwiftUIView.swift
//  My first app
//
//  Created by Jashnoor Singh on 18/06/26.
//

import SwiftUI

struct GameList: View {
    @State var games: [CodeBreaker] = []
    @Binding var selection: CodeBreaker?
    var body: some View {
        List(games, selection: $selection){ game in
            NavigationLink(value: game ){
                VStack(alignment: .leading){
                    Text(game.name).font(.title)
                    Choices(game: game)
                        .frame(maxHeight: 80)
                    Text("^[\(game.attempts.count) attempt](inflect: true)")
                        .font(.title3)
                }
            }
        }.toolbar{
            Button{
                withAnimation{
                    let game: CodeBreaker = CodeBreaker()
                    games.append(game)
                }
            }label:{ Image(systemName: "plus") }
        }
        .listStyle(.automatic)
            .navigationTitle("CodeBreaker")
            .navigationBarTitleDisplayMode(.large)
            .onAppear(){
                if games.isEmpty{
                    games.append(CodeBreaker(name: "MasterMind", pegChoices : [.red, .blue, .green, .yellow]))
                    games.append(CodeBreaker(name: "Earth Tones", pegChoices : [.brown, .orange, .black, .yellow, .green]))
                    games.append(CodeBreaker(name: "Aqua Tones", pegChoices : [.blue, .cyan, .indigo]))
                    selection = games.first
                }
            }
    }
}

#Preview {
    @Previewable @State var selection : CodeBreaker?
    NavigationStack{
        GameList(selection: $selection)
    }
}
