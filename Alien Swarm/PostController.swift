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
    
    @IBOutlet weak var optionalImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = post.title
        if(post.pic) { loadPic() }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadPic() {
//        var imageRequest: NSURLRequest = NSURLRequest(URL: NSURL(string: self.post.url)!)
//        NSURLConnection.sendAsynchronousRequest(imageRequest,
//                                                queue: NSOperationQueue.mainQueue(),
//                                                completionHandler: { response, data, error in
//            self.optionalImageView.image = UIImage(data: data)
//            self.optionalImageView.contentMode = UIViewContentMode.ScaleAspectFit
//        })
        FetchAsync(url: self.post.url) { data in
            if(data? != nil) {
                self.optionalImageView.image = UIImage(data: data!)
                // self.optionalImageView.contentMode = UIViewContentMode.ScaleAspectFit
            }
        }

    }

}
