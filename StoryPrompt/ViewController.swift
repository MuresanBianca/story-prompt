//
//  ViewController.swift
//  StoryPrompt
//
//  Created by Bianca Muresan on 10.11.2021.
//

import UIKit
import PhotosUI
import Photos

class ViewController: UIViewController {
    
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
        storyPromt.noun = "human"
        storyPromt.adjective = "smelly"
        storyPromt.verb = "run"
        storyPromptImageView.isUserInteractionEnabled = true
        
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeImage))
//        storyPromptImageView.addGestureRecognizer(gestureRecognizer)
//        print(storyPromt.description)
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
    }
    
    @IBAction func changeStory(_ sender: UIButton) {
        resignAllFirstResponders()
        updateStoryPrompt()
        changeImage()

    }
    
    //build in method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // resign first responder on all views
        self.view.endEditing(true)
    }
    
    func changeImage() {
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

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateStoryPrompt()
        return true
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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

