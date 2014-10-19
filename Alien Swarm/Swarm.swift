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
    let pic: Bool
    let url: String
    let thumb: String?
    init(title: String, pic: Bool, url: String, thumb: String) {
        self.title = title
        self.pic = pic
        self.url = url
        self.thumb = thumb
    }
}

class Swarm {
    var subreddits: [String] = []
    var posts: [Post] = []
    
    init() {
//        super.init()
        load()
    }
    
    func load() {
        for subreddit in ["apple", "swift", "pics"] {
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
                self.posts = map(children) { child in
                    let title: String = child["data"]["title"].stringValue!
                    let pic: Bool = child["data"]["domain"].stringValue! == "i.imgur.com"
                    let url: String = child["data"]["url"].stringValue!
                    let thumb: String = child["data"]["thumbnail"].stringValue!
                    let post = Post(title: title, pic: pic, url: url, thumb: thumb)
                    return post
                }
            }
            fn()
        })
    }
}

var swarm = Swarm()