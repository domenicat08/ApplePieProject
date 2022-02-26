//
//  Game.swift
//  Apple Pie
//
//  Created by Domenica Torres on 2/24/22.
//

import Foundation
//create a struct
struct Game{
    var word: String
    var incorrectMovesRemaining: Int
    //track how many letters the user has guessed:
    var guessedLetters:[Character] //array of character objects
    //create a computing property
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter){
                guessedWord += "\(letter)"
            }else{
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    
    mutating func playerGuessed(letter:Character){
        guessedLetters.append(letter)
        if !word.contains(letter){
            incorrectMovesRemaining -= 1 //using the minus to reduce this by one because the user is losing moves whenever they guess incorrectly
        }
        
    }
}
