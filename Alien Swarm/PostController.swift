//
//  PostController.swift
//  Alien Swarm
//
//  Created by Ben Yorke on 9/26/14.
//  Copyright (c) 2014 Ben Yorke. All rights reserved.
//

import UIKit

class PostController: UIViewController {
    
    var post:Post!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = post.title
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
