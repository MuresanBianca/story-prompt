//
//  getPromptNamePopUp.swift
//  StoryPrompt
//
//  Created by Bianca Muresan on 14.11.2021.
//

import UIKit
import Foundation

class PopUp: UIView {
    
    var storyName = ""
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 52.0/225, green: 28.0/225, blue: 68.0/225, alpha: 1.0)
        label.text = "Story Name"
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 52.0/225, green: 28.0/225, blue: 68.0/225, alpha: 1.0)
        label.text = "Give a funny name to your story."
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemPink
        label.text = "Please enter a valid story name!"
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    fileprivate var submitButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Submit", for: .normal)
        button.setTitleColor( UIColor(red: 121.0/250, green: 34.0/250, blue: 200.0/250, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
        return button
    }()
    
    fileprivate var discardButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Discard", for: .normal)
        button.setTitleColor( UIColor(red: 121.0/250, green: 34.0/250, blue: 200.0/250, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(discard), for: .touchUpInside)
        return button
    }()
    
    fileprivate var textField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor(red: 107.0/250, green: 59.0/250, blue: 177.0/250, alpha: 0.3)
        text.borderStyle = .roundedRect
        text.addTarget(self, action: #selector(clearError), for: .allTouchEvents)
        return text
    }()
    
    fileprivate lazy var buttonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [discardButton, submitButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    fileprivate lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    fileprivate lazy var finalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelStack,textField,buttonStack, errorLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 22
        return stack
    }()
    
    fileprivate let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 243.0/225, green: 245.0/225, blue: 248.0/225, alpha: 1.0)
        view.layer.cornerRadius = 24
        return view
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        self.frame = UIScreen.main.bounds
        self.addSubview(container)
        
        //-- container constraints
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        container.addSubview(finalStack)
        
        //-- textField constraints
        textField.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.7).isActive = true
        textField.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        //-- buttonStack constraints
        buttonStack.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        buttonStack.leadingAnchor.constraint(equalTo: finalStack.leadingAnchor).isActive = true
        buttonStack.trailingAnchor.constraint(equalTo: finalStack.trailingAnchor).isActive = true
        
        //-- labelStack constraints
        labelStack.centerXAnchor.constraint(equalTo: finalStack.centerXAnchor).isActive = true
        labelStack.leadingAnchor.constraint(equalTo: finalStack.leadingAnchor).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: finalStack.trailingAnchor).isActive = true
        
        //-- errorLabel constraints
        errorLabel.centerXAnchor.constraint(equalTo: finalStack.centerXAnchor).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: finalStack.leadingAnchor).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: finalStack.trailingAnchor).isActive = true
        
        //-- finalStack constraints
        finalStack.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        finalStack.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        finalStack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // resign first responder on all views
        self.endEditing(true)
    }
    
    func textFieldValidation() -> Bool {
        return !(textField.text ?? "").isEmpty
    }
    
    @objc func clearError() {
        errorLabel.isHidden = true
    }
    
    @objc func discard() {
        self.textField.resignFirstResponder()
        self.isHidden = true
    }
    
    @objc func submit() {
        self.textField.resignFirstResponder()
        if textFieldValidation() {
            storyName = textField.text!
            self.isHidden = true
            let name = Notification.Name(rawValue: popUpIsSelectedNotificationKey)
            NotificationCenter.default.post(name: name, object: nil)
        } else {
            errorLabel.isHidden = false
        }
    }
}
