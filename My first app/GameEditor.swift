//
//  GameEditor.swift
//  My first app
//
//  Created by Jashnoor Singh on 18/06/26.
//

import SwiftUI

struct GameEditor: View {
    @Binding var showGameEditor: Bool
    @Bindable var game: CodeBreaker
    var body: some View {
        NavigationStack{
            Form{
                Section("Name"){
                    TextField("Name", text: $game.name)
                }
                Section("Pegs"){
                    GameEditorPegChooser(pegChoices: $game.pegChoices)
                }
            }.toolbar{
                Button{ showGameEditor = false
                }label: {
                    HStack{
                        Text("Add Peg Choice")
                        Image(systemName: "plus.circle")
                    }
                }
            }
            
        }
    }
}

#Preview {
    @Previewable var game = CodeBreaker(name: "Untitled")
    @Previewable @State var showGameEditor = true
    GameEditor(showGameEditor: $showGameEditor ,game: game)
        .onChange(of: game.name){
            print("game name changed to \(game.name)")
        }
        .onChange(of: game.pegChoices){
            print("game pegs changed to \(game.pegChoices)")
        }
}
