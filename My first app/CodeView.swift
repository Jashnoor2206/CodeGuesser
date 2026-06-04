//
//  CodeView.swift
//  My first app
//
//  Created by Jashnoor Singh on 31/05/26.
//

import SwiftUI

struct CodeView: View {
    // MARK: Data in
    let code: Code
    // MARK: Binding Variable
    @Binding var selection: Int
    var body: some View {
        HStack{
            ForEach(code.pegs.indices, id: \.self){ index in
                PegView(peg: code.pegs[index])
                    .padding(5)
                    .background{
                        if selection == index, code.kind == .guess{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.gray.opacity(0.4))
                        }
                    }
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(code.isHidden ? Color.gray : Color.clear)
                    }
                    .onTapGesture {
                        if(code.kind == .guess){
                            selection = index
                        }
                    }
                }
//            Rectangle()
//                .fill(Color.clear)
//                .aspectRatio(0.75, contentMode: .fit)
//                .overlay{
//                    if let match = code.matches{
//                        Pins(matches: match) // this is from other file
//                    }
//                    else{
//                        if code.kind == .guess{
//                            guessButton
//                    }
//                }
//            }
        }
    }
}

//#Preview {
//    CodeView(code)
//}
