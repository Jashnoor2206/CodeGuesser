//
//  Code.swift
//  My first app
//
//  Created by Jashnoor Singh on 30/05/26.
// This is the Code Struct , usually when structs get big you give them a seperate file


import SwiftUI

struct Code{ // inside the code we have pegs of different color
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Code.missingPeg, count: 4) // this will make intial guesser transparent 
    static var missingPeg: Peg = .clear
    enum Kind: Equatable{
        case masterCode (isHidden: Bool)
        case guess
        case attempts ([Match])
        case unknown
    }
    
    mutating func randomize(from PegChoices: [Peg]){
        for index in pegs.indices{
            pegs[index] = PegChoices.randomElement() ?? Code.missingPeg
        }
    }
    
    var isHidden: Bool{
        switch kind{
        case .masterCode(let isHidden):
            return isHidden
        default:
            return false
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
        let backward_exactMatches = pegstoMatch.indices.reversed().map{ index in
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
