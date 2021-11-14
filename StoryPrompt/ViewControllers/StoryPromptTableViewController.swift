//
//  StoryPromptTableViewController.swift
//  StoryPrompt
//
//  Created by Bianca Muresan on 12.11.2021.
//

import UIKit

//UITableViewController which implements UITableViewDelegate delegate and UITableViewDataSource
//if you add a table view to a UIViewController you need to extend these 2 protocols

class StoryPromptTableViewController: UITableViewController {

    var storyPrompts = [StoryPromptEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    //-- from UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyPrompt = storyPrompts[indexPath.row]
        performSegue(withIdentifier: "ShowStoryPrompt", sender: storyPrompt)
    }
    
    //-- from UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //-- from UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storyPrompts.count
    }
    
    //-- from UITableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //try to seee if there is a previous available cell and using it as the template for the new cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryPromptCell", for: indexPath)
        cell.textLabel?.text = "Prompt \(indexPath.row + 1)"
        cell.imageView?.image = storyPrompts[indexPath.row].image
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStoryPrompt" {
            guard let storyPromptViewController = segue.destination as?
                    StoryPromptViewController,
                  let storyPrompt = sender as? StoryPromptEntry
            else {
                return
            }
            storyPromptViewController.storyPromt = storyPrompt

        }
    }
    
    @IBAction func saveStoryPrompt(unwindSegue: UIStoryboardSegue) {
        guard let storyPromptViewController = unwindSegue.source as?
                StoryPromptViewController,
              let storyPrompt = storyPromptViewController.storyPromt else {
                  return
              }
        storyPrompts.append(storyPrompt)
        tableView.reloadData()
    }

    @IBAction func cancelStoryPrompt(unwindSegue: UIStoryboardSegue) {
        
    }
}
