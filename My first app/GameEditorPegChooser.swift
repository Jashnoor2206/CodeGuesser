//
//  GameEditorPegChooser.swift
//  My first app
//
//  Created by Jashnoor Singh on 18/06/26.
//

import SwiftUI

struct GameEditorPegChooser: View {
    @Binding var pegChoices: [Peg]
    var body: some View {
        List{
            ForEach(pegChoices.indices, id: \.self){ index in
                ColorPicker(
                    selection: $pegChoices[index],
                    supportsOpacity: false
                ){
                    Button{
                        withAnimation{
                            var copy = pegChoices
                            copy.remove(at: index)
                            pegChoices = copy
                        }
                    }label:{
                        HStack{
                            Image(systemName: "minus.circle")
                                .tint(.red)
                            Text("Peg Choice \(index + 1)")
                                .tint(.primary)
                        }
                    }
                }
            }
            Button{
                withAnimation{
                    pegChoices.append(.black)
                }
            }label: {
                HStack{
                    Text("Add choice ")
                    Image(systemName: "plus.circle")
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var pegchoices: [Peg] = [.red, .blue, .green]
    GameEditorPegChooser(pegChoices: $pegchoices)
        .onChange(of: pegchoices){
            print("peg choices changed to \(pegchoices)")
        }
}
