//
//  GameChooser.swift
//  My first app
//
//  Created by Jashnoor Singh on 16/06/26.
//
import SwiftData
import SwiftUI

struct GameChooser: View {
    @State private var selection: CodeBreaker? = nil
    
    var body: some View {
        NavigationSplitView{
            GameList(selection: $selection)
        } detail: {
            if let selection {
                CodeBreakerView(game: selection)
                    .navigationTitle(selection.name)
            }
            else{
                Text("Choose a Game !")
                    .font(.title)
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    GameChooser()
        .modelContainer(for: CodeBreaker.self, inMemory: true)
}
