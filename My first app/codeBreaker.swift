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
    
    mutating func attemptGuess(){
        var attempt = guess
        attempt.kind = .attempts
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
    var pegs: [Peg] = [.green, .red, .blue, .yellow]
    static var missing: Peg = .clear
    enum Kind{
        case masterCode
        case guess
        case attempts
        case unknown
    }
    
    func match(against otherCode: Code) -> [Match]{
        var results: [Match] = Array(repeating: .nomatch, count: pegs.count)
        var pegstoMatch = otherCode.pegs
        for index in pegs.indices.reversed(){
            if pegstoMatch.count > index, pegstoMatch[index] == pegs[index]{
                results[index] = .exact
                pegstoMatch.remove(at: index)
            }
        }
        
        for index in pegs.indices{
            if results[index] != .exact {
                if let matchIndex = pegstoMatch.firstIndex(of: pegs[index]){
                    results[index] = .inexact
                    pegstoMatch.remove(at: matchIndex)
                }
            }
        }
        return results
    }
}
