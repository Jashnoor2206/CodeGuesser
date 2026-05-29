//
//  Pins.swift
//  My first app
//
//  Created by Jashnoor Singh on 26/05/26.
//
import SwiftUI

enum Match {
    case nomatch
    case exact
    case inexact
}
struct Pins: View{
    var matches : [Match]
    
    var body : some View{
        HStack{
            VStack{
                matchMarkers(peg: 0)
                matchMarkers(peg: 1)
            }
            VStack{
                matchMarkers(peg: 2)
                matchMarkers(peg: 3)
            }
        }
    }
    @ViewBuilder
    func matchMarkers(peg: Int) -> some View{
        let exact_count: Int = matches.count(where:{match in match == .exact})
        let found_count: Int = matches.count(where:{match in match != .nomatch})
        Circle()
            .fill(exact_count > peg ? Color.primary : Color.clear)
            .strokeBorder(found_count > peg ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
        
    }
}

#Preview {
    Pins(matches: [.exact, .inexact, .nomatch, .exact])
}
