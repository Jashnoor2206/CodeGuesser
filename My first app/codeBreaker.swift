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
    mutating func ChangeGuessPeg(at index: Int){
        let existingPeg = guess.pegs[index]
        if let indexofExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg){
            let newPeg = pegChoices[(indexofExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        }
        else{
            guess.pegs[index] = pegChoices.first ?? Code.missing
            
        }
    }
}

struct Code{ // inside the code we have pegs of different color
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Code.missing, count: 4) // this will make intial guesser transparent 
    static var missing: Peg = .clear
    enum Kind: Equatable{
        case masterCode
        case guess
        case attempts ([Match])
        case unknown
    }
    
    mutating func randomize(from PegChoices: [Peg]){
        for index in PegChoices.indices{
            pegs[index] = PegChoices.randomElement() ?? Code.missing
        }
    }
    
    var matches: [Match]?{
        switch kind{
        case .attempts(let matches): return matches
        default: return nil
        }
    }
    
    func match(against otherCode: Code) -> [Match]{
        var pegstoMatch = otherCode.pegs
        var backward_exactMatches = pegstoMatch.indices.reversed().map{ index in
            if pegstoMatch.count > index, pegstoMatch[index] == pegs[index]{
                pegstoMatch.remove(at: index)
                return Match.exact
            }
            else { return .nomatch }
        }
        let exactMatches = Array(backward_exactMatches.reversed())
        
        return pegs.indices.map{ index in
            if exactMatches[index] != .exact ,let matchIndex = pegstoMatch.firstIndex(of: pegs[index]){
                pegstoMatch.remove(at: matchIndex)
                return .inexact
            }
            else{
                return exactMatches[index]
            }
        }
    }
}
