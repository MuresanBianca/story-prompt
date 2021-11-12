//
//  ViewController.swift
//  StoryPrompt
//
//  Created by Bianca Muresan on 10.11.2021.
//

import UIKit
import PhotosUI
import Photos

class AddStoryPromptViewController: UIViewController {
    
    var storyPromt = StoryPromptEntry()
    
    //-- Outles
    @IBOutlet weak var nounTextField: UITextField!
    @IBOutlet weak var verbTextField: UITextField!
    @IBOutlet weak var adjectiveTextField: UITextField!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var storyPromptImageView: UIImageView!
    
    //-- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        numberSlider.value = 7.5
        storyPromt.number = Int(numberSlider.value)
        storyPromptImageView.isUserInteractionEnabled = true
        
        //add gesture recognizer on image
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        storyPromptImageView.addGestureRecognizer(gestureRecognizer)
        storyPromptImageView.isUserInteractionEnabled = true
}

    @IBAction func changeNumber(_ sender: UISlider) {
        resignAllFirstResponders()
        numberLabel.text = "Number: \(Int(sender.value))"
        storyPromt.number = Int(sender.value)
    }
    
    @IBAction func changeStoryType(_ sender: UISegmentedControl) {
        resignAllFirstResponders()
        if sender.selectedSegmentIndex == 0 {
            storyPromt.genre = .scifi
        } else {
            storyPromt.genre = .horror
        }
        storyPromt.updateStory(genre: storyPromt.genre)
    }
    
    @IBAction func changeStory(_ sender: UIButton) {
        resignAllFirstResponders()
        updateStoryPrompt()
        if storyPromt.isValid() {
            performSegue(withIdentifier: "StoryPrompt", sender: nil)
        } else {
            let alert = UIAlertController(title: "Invalid Story Prompt", message: "Please fill out all of the fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { action in }
            alert.addAction(action)
            present(alert, animated: true)
        }
        
    }
    
    //build in method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // resign first responder on all views
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StoryPrompt" {
            guard let storyPromptViewController = segue.destination as? StoryPromptViewController else {
                return
            }
            storyPromptViewController.storyPromt = storyPromt
        }
    }
    
    //what happen when the image view is tapped
    @objc func changeImage() {
        //open image picker
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary //or .camera
        pickerController.delegate = self
        //it requires a person to select a cropped square part of the photo
        pickerController.allowsEditing = true
        present(pickerController,animated: true)
    }
    
    
    func resignAllFirstResponders() {
        self.nounTextField.resignFirstResponder()
        self.verbTextField.resignFirstResponder()
        self.adjectiveTextField.resignFirstResponder()
    }
    
    func updateStoryPrompt(){
        storyPromt.noun = nounTextField.text ?? ""
        storyPromt.verb = verbTextField.text ?? ""
        storyPromt.adjective = adjectiveTextField.text ?? ""
    }
    
    func configureTextFields() {
        nounTextField.delegate = self
        verbTextField.delegate = self
        adjectiveTextField.delegate = self
    }
}

extension AddStoryPromptViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateStoryPrompt()
        return true
    }
}

extension AddStoryPromptViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //when the user select an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //info dictionary
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            storyPromptImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    //when user press cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

