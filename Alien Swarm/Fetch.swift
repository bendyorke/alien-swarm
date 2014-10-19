//
//  Fetch.swift
//  Alien Swarm
//
//  Created by Ben Yorke on 10/15/14.
//  Copyright (c) 2014 Ben Yorke. All rights reserved.
//

import UIKit

class FetchAsync {
    var url: String
    var callback: (NSData?) -> ()
    
    init(url: String, callback: (NSData?) -> ()) {
        self.url = url
        self.callback = callback
        self.fetch()
    }
    
    func fetch() {
        var imageRequest: NSURLRequest = NSURLRequest(URL: NSURL(string: self.url)!)
        NSURLConnection.sendAsynchronousRequest(imageRequest,
            queue: NSOperationQueue.mainQueue(),
            completionHandler: { response, data, error in
                if(error == nil) {
                    self.callback(data)
                } else {
                    self.callback(nil)
                }
        })
        callback(nil)
    }
}
