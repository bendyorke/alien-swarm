//
//  Swarm.swift
//  Alien Swarm
//
//  Created by Ben Yorke on 9/26/14.
//  Copyright (c) 2014 Ben Yorke. All rights reserved.
//

import UIKit

class Post {
    let title: String
    init(title: String) {
        self.title = title
    }
}

class Swarm: NSObject {
    var subreddits: [String] = []
    var posts: [Post] = []
    
    override init() {
        super.init()
        load()
    }
    
    func load() {
        for subreddit in ["apple", "swift"] {
            self.add(subreddit)
        }
    }
    
    func add(subreddit: String) {
        subreddits.append(subreddit)
    }
    
    func url() -> String {
        let multi = "+".join(subreddits)
        return "https://reddit.com/r/\(multi).json"
    }
    
    func fetch(fn: () -> ()) {
        let req = Agent.get(self.url())
        req.end({ (response: NSHTTPURLResponse!, data: Agent.Data!, error: NSError!) -> Void in
            let json = JSON(object: data!)
            if let children = json["data"]["children"].arrayValue {
                self.posts = []
                for child in children {
                    let title: String = child["data"]["title"].stringValue!
                    let post = Post(title: title)
                    self.posts.append(post)
                }
            }
            fn()
        })
    }
}

var swarm = Swarm()