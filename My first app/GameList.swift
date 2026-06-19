//
//  SwiftUIView.swift
//  My first app
//
//  Created by Jashnoor Singh on 18/06/26.
//

import SwiftUI

struct GameList: View {
    @State var games: [CodeBreaker] = []
    @State private var showGameEditor: Bool = false
    @State var newGame : CodeBreaker?
    @Binding var selection: CodeBreaker?
    
    var body: some View {
        List(selection: $selection){
            ForEach(games){ game in // introducing for each becuase swipe to delete works
                NavigationLink(value: game ){
                    VStack(alignment: .leading){
                        Text(game.name).font(.title)
                        Choices(game: game)
                            .frame(maxHeight: 80)
                        Text("^[\(game.attempts.count) attempt](inflect: true)")
                            .font(.title3)
                    }
                }
            }
            .onDelete{ index in // allows swipe to delete
                games.remove(atOffsets: index)
            }
            .onMove{ startingIndex, destinationIndex in // allows to hold to move
                games.move(fromOffsets: startingIndex, toOffset: destinationIndex)
            }
        }.toolbar{
            Button{ newGame = CodeBreaker()
            }label:{ Image(systemName: "plus") }
                .sheet(isPresented: $showGameEditor){
                    if let newGame{
                        GameEditor(showGameEditor: $showGameEditor, game: newGame)
                    }
                }
                .onChange(of: newGame){
                    showGameEditor = newGame != nil // this line tells only change showGameEditor when new game is changed and not equal to nil
                }
        }
        .onChange(of: showGameEditor){ oldValue, newValue in
            if oldValue == true , newValue == false{
                if let newGame{
                    withAnimation{
                        games.insert(newGame, at: 0)
                    }
                }
                newGame = nil // setting back to nil
            }
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
