//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Padmanabhan, Avinash on 4/14/17.
//  Copyright © 2017 Intuit. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var tweets = [Tweet]()
    var minTweetId = INT64_MAX
    var profile: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120

        //pull to refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        //add spinner for infinity scroll
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
        self.tableView.tableFooterView = spinner;

        fetchTweets(maxId: -1)
    }

    @IBAction func onLogout(_ sender: Any) {
        TwitterClient.sharedInstance.logout()
    }
    
    @IBAction func onTapGesture(_ sender: UITapGestureRecognizer) {
        if let tappedRow = sender.view?.tag {
            let tweet = tweets[tappedRow]
            profile = tweet.user
        }
        performSegue(withIdentifier: "userToProfile", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == self.tweets.count - 2) {
            fetchTweets(maxId: minTweetId)
        }
    }
    
    //get updated data
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchTweets(maxId: -1)
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tweetDetailSegue" {
            let cell = sender as! TweetCell
            
            let navigationController = segue.destination as! UINavigationController
            let detailsViewController = navigationController.topViewController as! DetailsViewController
            detailsViewController.tweet = cell.tweet
        } else if segue.identifier == "userToProfile" {
            let profileViewController = segue.destination as! ProfileViewController
            if let profile = profile {
                print("Profile \(profile)")
                //profileViewController.userData = profile
            }
        }
    }
    
    func fetchTweets(maxId: Int64) {
        TwitterClient.sharedInstance.homeTimeline(withMaxId: maxId, success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.minTweetId = self.getMinTweetId(tweets: tweets)
            self.tableView.reloadData()
        }) { (error: Error) in
            print("error: \(error.localizedDescription)")
        }
    }
    
    func getMinTweetId(tweets: [Tweet]) -> Int64 {
        var minId = INT64_MAX
        for tweet in tweets {
            if tweet.tweetId! < minId {
                minId = tweet.tweetId!
            }
        }
        return minId
    }
}
