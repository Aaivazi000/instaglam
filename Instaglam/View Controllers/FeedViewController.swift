//
//  FeedViewController.swift
//  Instaglam
//
//  Created by Andriana Aivazians on 10/22/18.
//  Copyright © 2018 Andriana Aivazians. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //UI Outlets & Variable Declarations
    @IBOutlet weak var photofeedTableView: UITableView!
    var posts: [PFObject] = []
    var feedRefreshControl: UIRefreshControl!
    
    

    //Logout Function
    @IBAction func signoutAction(_ sender: Any) {
        PFUser.logOutInBackground {(error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            }
        }
    }
    
    //Required Function that determines number of cells in TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    //Required Function that determines what goes in each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = photofeedTableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.instagramPost = posts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        photofeedTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Preparation for TableView
        photofeedTableView.dataSource = self
        photofeedTableView.delegate = self
        photofeedTableView.rowHeight = 451
        
        //For Refresh Control
        feedRefreshControl = UIRefreshControl()
        feedRefreshControl.addTarget(self, action: #selector(FeedViewController.didPulltoRefresh(_:)), for: .valueChanged)
        photofeedTableView.insertSubview(feedRefreshControl, at: 0)
        
        //Get Posts
        fetchPosts()
    }
    
    //Refresh Control Required Function
    @objc func didPulltoRefresh(_ refreshControll: UIRefreshControl) {
        fetchPosts()
    }
    

    //Function to get posts from Parse
    func fetchPosts() {
        // construct PFQuery
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                print( "Posts are: ", posts)
                self.posts = posts
            }
            else {
                print("Error is: ", error?.localizedDescription ?? "No localized error")
            }
            self.photofeedTableView.reloadData()
        }
        self.feedRefreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FeedDetailSegue" {
            let cell = sender as! UITableViewCell
            if let indexPath = photofeedTableView.indexPath(for: cell) {
                let post = posts[indexPath.row]
                let detailViewController = segue.destination as! FeedDetailViewController
                detailViewController.detailpost = post
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
