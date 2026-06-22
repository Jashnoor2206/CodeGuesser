//
//  Code.swift
//  My first app
//
//  Created by Jashnoor Singh on 30/05/26.
// This is the Code Struct , usually when structs get big you give them a seperate file


import SwiftUI
import SwiftData

@Model class Code { // inside the code we have pegs of different color
    var _kind: String = ""
    var _pegs: [String] = []
    
    init(kind: Kind, pegs: [Peg] = Array(repeating: Code.missingPeg, count: 4)) {
        self.kind = kind
        self.pegs = pegs
    }
    
    var pegs: [Peg]{
        get {
            _pegs.compactMap { Peg(string: $0) }
        }
        set {
            _pegs = newValue.map { $0.toString }
        }
    }
    static var missingPeg: Peg = .clear
    
    enum Kind: Codable, Hashable{
        case masterCode (isHidden: Bool)
        case guess
        case attempts ([Match])
        case unknown
    }
    
    var kind: Kind{
        get{
            guard let data = _kind.data(using: .utf8),
                  let decoded = try? JSONDecoder().decode(Kind.self, from: data)
            else { return .unknown }
            return decoded
        }
        set{
            if let data = try? JSONEncoder().encode(newValue),
               let string = String(data: data, encoding: .utf8) {
                _kind = string
            }
        }
    }
    
    func randomize(from PegChoices: [Peg]){
        for index in pegs.indices{
            pegs[index] = PegChoices.randomElement() ?? Code.missingPeg
        }
        print(pegs.map{$0.debugName})
        
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
            if pegstoMatch.count > index, pegstoMatch[index].isApproximately(pegs[index]){
                pegstoMatch.remove(at: index)
                return Match.exact
            }
            else { return .nomatch }
        }
        let exactMatches = Array(backward_exactMatches.reversed())
        
        return pegs.indices.map{ index in
            if exactMatches[index] != .exact, let matchIndex = pegstoMatch.firstIndex(where: { $0.isApproximately(pegs[index]) }){
                pegstoMatch.remove(at: matchIndex)
                return .inexact
            }
            else{
                return exactMatches[index]
            }
        }
    }
}

enum Match : Codable, Hashable{
    case nomatch
    case exact
    case inexact
}
