//
//  ViewController.swift
//  Apple Pie
//
//  Created by Domenica Torres on 2/24/22.
//

import UIKit

class ViewController: UIViewController {
    //create connections for the labels:
    //drag the top label
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    //1.create some variable to track a list of words:
    //2.create a constant cause it won't change that determines how many turns the user has taken
    //3.define how many times the user has lost or won. It will change so it's var
    var listOfWords = ["buccaneer","swift","glorious","incandenscent","bug","program"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet{
            newRound() //fixing the bug
        }
    }
    var totalLosses = 0 {
        didSet{
            newRound()
        }
    }
    var currentGame: Game! //will hold the "game" struct, ! tells the compiler that it's okay if this variable does not have a initial value
    
    //create an action that all the buttons can call
    //connect all the buttons to the below action:
    @IBAction func buttonPressed(_ sender: UIButton) {
        //disable the button after selecting it:
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        //update the game state
        currentGame.playerGuessed(letter: letter)
        
        updateGameState()
    }
    override func viewDidLoad() { //one outlet that connects to many objects of the same kind
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()//new method
    }
    func newRound(){
        if !listOfWords.isEmpty {
        //add a new struct file called game (see "game" file)
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(_enable: true)
            //initialize  the UI
        updateUI()
        }else{
            enableLetterButtons(_enable: false)
        }
    }
    func enableLetterButtons(_enable: Bool) {
        for button in letterButtons{
            button.isEnabled = _enable
        }
    }
    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
    
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        //reference the UI image to the image name
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
    }
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses += 1
    }else if currentGame.word == currentGame.formattedWord{
        totalWins += 1
    }else {
        updateUI()
    }
    }
}
