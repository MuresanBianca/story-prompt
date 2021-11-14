//
//  StoryPromptViewController.swift
//  StoryPrompt
//
//  Created by Bianca Muresan on 12.11.2021.
//

import UIKit

let popUpIsSelectedNotificationKey = "mbm.popup.isselected"

class StoryPromptViewController: UIViewController {
    
    var storyPromt: StoryPromptEntry?
    var isNewStoryPrompt = false
    let popUP = PopUp()
    let submited = Notification.Name(rawValue: popUpIsSelectedNotificationKey)

    //-- Outles
    @IBOutlet weak var storyPromptTextView: UITextView!
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    //-- Functions
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyPromptTextView.text = storyPromt?.description
        view.addSubview(popUP)
        popUP.isHidden = true
        createObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isNewStoryPrompt {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        } else {
            discardButton.isHidden = true
            saveButton.isHidden = true
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func discardStory(_ sender: UIButton) {
        sender.configuration?.baseBackgroundColor = UIColor(red: 243.0/255, green: 245.0/255, blue: 248.0/255, alpha: 0.79)
        
        performSegue(withIdentifier: "CancelStoryPrompt", sender: nil)
    }
    
    @IBAction func saveStory(_ sender: UIButton) {
        
        sender.configuration?.baseBackgroundColor = UIColor(red: 243.0/255, green: 245.0/255, blue: 248.0/255, alpha: 0.79)
        
        popUP.isHidden = false
          
    }
    
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(StoryPromptViewController.performSegue(notification:))  , name: submited, object: nil)
    }
    
    @objc func performSegue(notification: NSNotification) {
        storyPromt?.name = popUP.storyName
        performSegue(withIdentifier: "SaveStoryPrompt", sender: nil)
    }
    
    @IBAction func touchDown(_ sender: UIButton) {
        sender.configuration?.baseBackgroundColor = UIColor(red: 107.0/255, green: 59.0/255, blue: 177.0/255, alpha: 0.59)
    }
    
    
    
}


