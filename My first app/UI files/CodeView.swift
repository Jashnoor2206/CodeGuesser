//
//  CodeView.swift
//  My first app
//
//  Created by Jashnoor Singh on 31/05/26.
//

import SwiftUI

struct CodeView<SideView>: View where SideView: View {
    // MARK: Data in
    let code: Code
    // MARK: Binding Variable
    @Binding var selection: Int
    @ViewBuilder let sideView: () -> SideView
    @Namespace private var selectionNamespace
    
    init(code: Code,
         selection: Binding<Int> = .constant(-1),
         @ViewBuilder sideView: @escaping () -> SideView = {EmptyView()}){
        self.code = code
        self._selection = selection
        self.sideView = sideView
    }
    
    var body: some View {
        HStack{
            ForEach(code.pegs.indices, id: \.self){ index in
                PegView(peg: code.pegs[index])
                    .padding(5)
                    .background{
                        Group{
                            if selection == index, code.kind == .guess{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(Color.gray.opacity(0.4))
                                    .matchedGeometryEffect(id: "selection", in: selectionNamespace)
                            }
                        }.animation(.guess, value: selection)
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
                    .transaction{ transaction in
                        if code.isHidden {
                            transaction.animation = nil
                        }
                    }
                }
            Rectangle()
                .fill(Color.clear)
                .aspectRatio(0.75, contentMode: .fit)
                .overlay{
                    sideView()
                }
            }
        }
    }

