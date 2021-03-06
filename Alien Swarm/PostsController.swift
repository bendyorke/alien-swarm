//
//  SecondViewController.swift
//  Alien Swarm
//
//  Created by Ben Yorke on 9/25/14.
//  Copyright (c) 2014 Ben Yorke. All rights reserved.
//

import UIKit

class PostsController: UITableViewController, UITabBarControllerDelegate {
    
    var imageCache = [String : UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pull to refresh
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Re-swarm")
        refreshControl!.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!)
        refresh()
        
        // Refresh on tab change
        self.tabBarController?.delegate = self
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return swarm.posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as PostCell
        let post = swarm.posts[indexPath.row]
        cell.title!.text = post.title
        
        if(post.thumb? != nil && post.thumb!.rangeOfString("http") != nil) {
            cell.thumb!.image = UIImage(named: "first.imageset")
            cell.thumb!.contentMode = .ScaleAspectFit
            var image = self.imageCache[post.thumb!]
            
            if(image == nil) {
                FetchAsync(url: post.thumb!) { data in
                    if(data? != nil) {
                        image = UIImage(data: data!)
                        self.imageCache[post.thumb!] = image
                        dispatch_async(dispatch_get_main_queue(), {
                            if let postCell = tableView.cellForRowAtIndexPath(indexPath) as? PostCell {
                                postCell.thumb!.image = image
                            }
                        })
                    }
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    if let postCell = tableView.cellForRowAtIndexPath(indexPath) as? PostCell {
                        postCell.thumb!.image = image
                    }
                })
            }
        } else {
            cell.thumb!.image = nil
        }
        
        return cell
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showPost") {
            let index = tableView.indexPathForSelectedRow()
            var postController = segue.destinationViewController as PostController
            postController.post = swarm.posts[index!.row]
        }
        if(segue.identifier == "showSubreddits") {
            var navController = segue.destinationViewController as UINavigationController
            var subredditsController = navController.viewControllers[0] as SubredditsController
            subredditsController.postsController = self
        }
    }
    
    // Refresh
    
    func refresh() {
        fetch()
        self.refreshControl!.endRefreshing()
    }
    
    func fetch() {
        swarm.fetch({
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        })
    }

}

