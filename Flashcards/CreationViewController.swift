//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Marc Alejandro on 10/13/18.
//  Copyright © 2018 Marc Alejandro. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashCardsController: ViewController!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnCancel(_ sender: Any)
    {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any)
    {
        let questionText = questionTextField.text
        
        let answerText = answerTextField.text
        
        flashCardsController.updateFlashcard(question: questionText!, answer: answerText!)
        
        dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
