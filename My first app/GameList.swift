//
//  SwiftUIView.swift
//  My first app
//
//  Created by Jashnoor Singh on 18/06/26.
//

import SwiftUI
import SwiftData

struct GameList: View {
    @Query(sort: \CodeBreaker.createdDate, order: .reverse) private var games: [CodeBreaker]
    @Environment(\.modelContext) private var modelContext
    @State private var showAlert: Bool = false
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
                .swipeActions(edge: .leading){
                    Button{
                        newGame = game
                        showGameEditor = true
                    }label:{
                        Label("Edit", systemImage: "pencil")
                    }.tint(.blue)
                }
            }
            .onDelete{ offset in // allows swipe to delete
                for index in offset{
                    modelContext.delete(games[index])
                }
            }
        }.toolbar{
            Button{ newGame = CodeBreaker()
            }label:{ Image(systemName: "plus") }
                .sheet(isPresented: $showGameEditor, onDismiss: {newGame = nil}){
                    if let newGame{
                        NavigationStack{
                            GameEditor(showGameEditor: $showGameEditor, game: newGame)
                                .toolbar{
                                    ToolbarItem(placement: .cancellationAction){
                                        Button{
                                            self.newGame = nil
                                        }label: {Text("Cancel")}
                                    }
                                    ToolbarItem(placement: .confirmationAction){
                                        Button{
                                            if Set(newGame.pegChoices).count < 2 || newGame.name.isEmpty{
                                                showAlert = true
                                            }
                                            else{
                                                withAnimation{
                                                    modelContext.insert(newGame)
                                                    self.newGame = nil
                                                }
                                            }
                                        }label: { Text("Done") }
                                            .alert("Note", isPresented: $showAlert){
                                                Button("OK"){ showAlert = false }
                                            }message:{
                                                Text("You can only add a game with a name and minimum two unique pegs")
                                            }

                                    }
                                }
                        }
                    }
                }
                .onChange(of: newGame){
                    showGameEditor = newGame != nil // this line tells only change showGameEditor when new game is changed and not equal to nil
                }
        }
        .listStyle(.automatic)
            .navigationTitle("CodeBreaker")
            .navigationBarTitleDisplayMode(.large)
            .onAppear(){
                if games.isEmpty{
                    modelContext.insert(CodeBreaker(name: "MasterMind", pegChoices : [.red, .blue, .green, .yellow]))
                    modelContext.insert(CodeBreaker(name: "Earth Tones", pegChoices : [.brown, .orange, .black, .yellow, .green]))
                    modelContext.insert(CodeBreaker(name: "Aqua Tones", pegChoices : [.blue, .cyan, .indigo]))
//                    selection = games.first
                }
            }
    }
}

#Preview {
    @Previewable @State var selection : CodeBreaker?
    NavigationStack{
        GameList(selection: $selection)
            .modelContainer(for: CodeBreaker.self, inMemory: true)
    }
}
