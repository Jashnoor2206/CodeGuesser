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
        Form{
            Section("Name"){
                TextField("Name", text: $game.name)
            }
            Section("Pegs"){
                GameEditorPegChooser(pegChoices: $game.pegChoices)
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
