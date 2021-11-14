//
//  StoryPromptViewController.swift
//  StoryPrompt
//
//  Created by Bianca Muresan on 12.11.2021.
//

import UIKit

class StoryPromptViewController: UIViewController {
    
    var storyPromt: StoryPromptEntry?
    
    //-- Outles
    @IBOutlet weak var storyPromptTextView: UITextView!
    
    
    
    //-- Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyPromptTextView.text = storyPromt?.description
    }

    @IBAction func discardStory(_ sender: UIButton) {
        sender.configuration?.baseBackgroundColor = UIColor(red: 243.0/255, green: 245.0/255, blue: 248.0/255, alpha: 0.79)
    }
    
    @IBAction func saveStory(_ sender: UIButton) {
        sender.configuration?.baseBackgroundColor = UIColor(red: 243.0/255, green: 245.0/255, blue: 248.0/255, alpha: 0.79)
    }
    
    @IBAction func touchDown(_ sender: UIButton) {
        sender.configuration?.baseBackgroundColor = UIColor(red: 107.0/255, green: 59.0/255, blue: 177.0/255, alpha: 0.59)
    }
    
}


