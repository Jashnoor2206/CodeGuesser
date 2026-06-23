//
//  codeBreaker.swift
//  My first app
//
//  Created by Jashnoor Singh on 27/05/26.
//

import SwiftUI
import SwiftData

typealias Peg = Color // here essentially we make Peg an alias of color because for now pegs are just the colors , but since Color is the UI thing so we need to import swiftUI instead of Foundation

@Model class CodeBreaker {
    var name : String
    var createdDate: Date = Date()
    @Relationship(deleteRule: .cascade) var MasterCode: Code
    @Relationship(deleteRule: .cascade) var guess: Code
    @Relationship(deleteRule: .cascade) var attempts: [Code]
    var _pegChoices: [String] = []

    init(name: String = "Untitled", pegChoices : [Peg] = [.red, .blue, .brown, .yellow]){
        self.name = name
        self.createdDate = Date()
        self.MasterCode = Code(kind: .masterCode(isHidden: true))
        self.guess = Code(kind: .guess)
        self.attempts = []
        MasterCode.randomize(from: pegChoices)
        guess.pegs = Array(repeating: Color.clear, count: 4)
        self.pegChoices = pegChoices
    }
    
    var pegChoices: [Peg]{
        get {
            _pegChoices.compactMap { Peg(string: $0) }
        }
        set {
            _pegChoices = newValue.map { $0.toString }
        }
    }
    
    var isOver: Bool{
        attempts.first?.pegs.isApproximately(MasterCode.pegs) ?? false
    }
    
    func attemptGuess(){
        guard !attempts.contains(where: { $0.pegs.isApproximately(guess.pegs) }) else { return }
        let attempt = Code(kind: .attempts(guess.match(against: MasterCode)), pegs: guess.pegs)
        attempts.insert(attempt, at: 0) // insert element at the begining
        if isOver{
            MasterCode.kind = .masterCode(isHidden: false)
        }
    }
    
    func setGuesspeg(_ peg : Peg, at index: Int){
        guard guess.pegs.indices.contains(index) else {return} // this makes sure that index is always in bounds of indices 
        guess.pegs[index] = peg
    }
    
    func restart(){
        MasterCode.kind = .masterCode(isHidden: true)
        guess.pegs = Array(repeating: Color.clear, count: 4)
        attempts.removeAll()
        MasterCode.randomize(from: pegChoices)
    }
    
}


