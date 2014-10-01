//
//  AddSubredditsController.swift
//  Alien Swarm
//
//  Created by Ben Yorke on 9/25/14.
//  Copyright (c) 2014 Ben Yorke. All rights reserved.
//

import UIKit

class AddSubredditsController: UIViewController, UITextFieldDelegate {

    @IBAction func done(sender: UIBarButtonItem) {
        subreddit.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func add(sender: UIBarButtonItem) {
        submit()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        submit()
        return true
    }
    
    func submit() {
        swarm.add(subreddit.text)
        subreddit.text = nil
    }
    
    @IBOutlet var subreddit: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subreddit.becomeFirstResponder()
        subreddit.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
