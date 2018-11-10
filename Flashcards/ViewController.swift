//
//  ViewController.swift
//  Flashcards
//
//  Created by Marc Alejandro on 10/13/18.
//  Copyright © 2018 Marc Alejandro. All rights reserved.
//

import UIKit

struct Flashcard
{
    var question: String
    var answer: String
}

class ViewController: UIViewController
{
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    // array to hold flashcards
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // read saved flashcards
        readSavedFlashcards()
        
        // if nothing is saved
        if flashcards.count == 0
        {
            updateFlashcard(question: "What is the powerhouse of the cell?", answer: "The Mitochondria.")
        }
        else
        {
            updateLabels()
            updateNextPrevButtons()
        }
        
    }

    @IBAction func didTapOnFlashCard(_ sender: Any)
    {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOnNext(_ sender: Any)
    {
        // increment current index
        currentIndex += 1
        
        // update labels
        updateLabels()
        
        // update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any)
    {
        // increment current index
        currentIndex -= 1
        
        // update labels
        updateLabels()
        
        // update buttons
        updateNextPrevButtons()
    }
    
    func updateFlashcard(question: String, answer: String)
    {
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        flashcards.append(flashcard)
        
        // print to console for debug purposes
        print("flashcard added.")
        print("there are now \(flashcards.count) flashcards.")
        
        // update current index
        currentIndex = flashcards.count - 1
        print("current index: \(currentIndex)")
        
        //update buttons
        updateNextPrevButtons()
        
        // update labels
        updateLabels()
        
        // save flash cards
        saveAllFlashcardsToDisk()
    }
    
    func updateLabels()
    {
        // get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        // update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func updateNextPrevButtons()
    {
        // disable next button at the end
        if currentIndex == flashcards.count - 1
        {
            nextButton.isEnabled = false
        }
        else
        {
            nextButton.isEnabled = true
        }
        
        // disable prev button at beginning
        
        if currentIndex == 0
        {
            prevButton.isEnabled = false
        }
        else
        {
            prevButton.isEnabled = true
        }
    }
    
    func saveAllFlashcardsToDisk()
    {
        
        // flashcard array => dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("flashcards saved to UserDefaults.")
    }
    
    func readSavedFlashcards()
    {
        // read dictionary array from disk, if any
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]
        {
            // the code runs if there is a dictionary array present
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            // add cards into array
            flashcards.append(contentsOf: savedCards)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashCardsController = self
        
    }
    
}

