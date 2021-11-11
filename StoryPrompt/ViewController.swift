//
//  ViewController.swift
//  StoryPrompt
//
//  Created by Bianca Muresan on 10.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var storyPromt = StoryPromptEntry()
    
    //-- Outles
    @IBOutlet weak var nounTextField: UITextField!
    @IBOutlet weak var verbTextField: UITextField!
    @IBOutlet weak var adjectiveTextField: UITextField!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var numberLabel: UILabel!
    
    //-- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberSlider.value = 7.5
        storyPromt.number = Int(numberSlider.value)
        storyPromt.noun = "human"
        storyPromt.adjective = "smelly"
        storyPromt.verb = "run"
        
        print(storyPromt.description)
    }

    @IBAction func changeNumber(_ sender: UISlider) {
        numberLabel.text = "Number: \(Int(sender.value))"
        storyPromt.number = Int(sender.value)
    }
    
    @IBAction func changeStoryType(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            storyPromt.genre = .scifi
        } else {
            storyPromt.genre = .horror
        }
        print(storyPromt.genre)
    }
}


