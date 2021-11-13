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
}
