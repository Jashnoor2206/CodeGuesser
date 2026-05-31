//
//  codeBreaker.swift
//  My first app
//
//  Created by Jashnoor Singh on 27/05/26.
//

import SwiftUI

typealias Peg = Color // here essentially we make Peg an alias of color because for now pegs are just the colors , but since Color is the UI thing so we need to import swiftUI instead of Foundation

struct CodeBreaker{
    var MasterCode: Code = Code(kind: .masterCode)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = [] // create an empty array for time being 
    let pegChoices: [Peg] = [.red, .blue, .green, .yellow]
    
    init(){
        MasterCode.randomize(from: pegChoices)
        guess.pegs = Array(repeating: Color.clear, count: 4)
        print(MasterCode)
    }
    
    mutating func attemptGuess(){
        var attempt = guess
        attempt.kind = .attempts(guess.match(against: MasterCode))
        attempts.append(attempt)
    }
    
    mutating func setGuesspeg(_ peg : Peg, at index: Int){
        guard guess.pegs.indices.contains(index) else {return} // this makes sure that index is always in bounds of indices 
        guess.pegs[index] = peg
    }
    
}


