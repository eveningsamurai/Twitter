//
//  DetailsViewController.swift
//  Twitter
//
//  Created by Padmanabhan, Avinash on 4/14/17.
//  Copyright © 2017 Intuit. All rights reserved.
//

import UIKit
import AFNetworking

class DetailsViewController: UIViewController {

    var tweet: Tweet?
    var alreadyRetweeted: Bool?
    var alreadyFavorited: Bool?
    
    @IBOutlet weak var detailProfileImageView: UIImageView!
    @IBOutlet weak var detailProfileNameLabel: UILabel!
    @IBOutlet weak var detailProfileScreenNameLabel: UILabel!
    @IBOutlet weak var detailProfileTweetLabel: UILabel!
    @IBOutlet weak var detailProfileFavoritesLabel: UILabel!
    @IBOutlet weak var detailProfileTimestampLabel: UILabel!
    @IBOutlet weak var detailProfileRetweetsLabel: UILabel!
    @IBOutlet weak var detailProfileReplyButton: UIButton!
    @IBOutlet weak var detailProfileRetweetButton: UIButton!
    @IBOutlet weak var detailProfileFavButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailProfileTweetLabel.text = tweet?.text
        detailProfileNameLabel.text = tweet?.user?.name
        detailProfileScreenNameLabel.text = tweet?.user?.screenName
        detailProfileImageView.setImageWith((tweet?.user?.profileUrl)!)
        detailProfileRetweetsLabel.text = String(tweet!.retweetCount)
        detailProfileFavoritesLabel.text = String(tweet!.favoritesCount)
        
        alreadyRetweeted = (tweet?.retweeted)!
        if(self.alreadyRetweeted)! {
            self.detailProfileRetweetButton.imageView?.image = UIImage(named: "twitter_rted")
        } else {
            self.detailProfileRetweetButton.imageView?.image = UIImage(named: "twitter_rt")
        }

        alreadyFavorited = (tweet?.favorited)!
        if(self.alreadyFavorited)! {
            self.detailProfileFavButton.imageView?.image = UIImage(named: "twitter_faved")
        } else {
            self.detailProfileFavButton.imageView?.image = UIImage(named: "twitter_fav")
        }
        
        let ts = tweet?.timestamp
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let dateString = dateFormatter.string(from: ts as! Date)
        detailProfileTimestampLabel.text = dateString
        
        detailProfileImageView.setImageWith((tweet?.user?.profileUrl)!)        
    }

    @IBAction func onHomeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onReplyBarButton(_ sender: Any) {
        self.performSegue(withIdentifier: "tweetReplySegue", sender: sender)
    }

    @IBAction func onReplyLabel(_ sender: Any) {
        self.performSegue(withIdentifier: "tweetReplySegue", sender: sender)
    }
    
    @IBAction func onRetweetLabel(_ sender: Any) {
        TwitterClient.sharedInstance.retweet(withTweetId: (tweet?.tweetId)!, alreadyRetweeted: alreadyRetweeted!,
            success: { (tweet: Tweet) in
                let alert = UIAlertController(title: "Retweet",
                                              message: "Retweet posted",
                    preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK",
                                             style: .destructive,
                                             handler: { (action) in })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                self.alreadyRetweeted = !self.alreadyRetweeted!
                if(self.alreadyRetweeted)! {
                    self.detailProfileRetweetButton.imageView?.image = UIImage(named: "twitter_rted")
                } else {
                    self.detailProfileRetweetButton.imageView?.image = UIImage(named: "twitter_rt")
                }
                self.view.setNeedsDisplay()
            },
            failure: { (error: Error) in
                print("Unable to retweet! because of error: \(error.localizedDescription)")
            }
        )
    }
    
    @IBAction func onFavButton(_ sender: Any) {
        TwitterClient.sharedInstance.favorite(withTweetId: (tweet?.tweetId)!, alreadyFavorited: alreadyFavorited!,
             success: { (tweet: Tweet) in
                let alert = UIAlertController(title: "Favorite",
                                              message: "Favorite posted",
                                              preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK",
                                             style: .destructive,
                                             handler: { (action) in })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                self.alreadyFavorited = !self.alreadyFavorited!
                if(self.alreadyFavorited)! {
                    self.detailProfileFavButton.imageView?.image = UIImage(named: "twitter_faved")
                } else {
                    self.detailProfileFavButton.imageView?.image = UIImage(named: "twitter_fav")
                }
            },
             failure: { (error: Error) in
                print("Unable to favorite! because of error: \(error.localizedDescription)")
            }
        )
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tweetReplySegue" {
            let navigationController = segue.destination as! UINavigationController
            let replyViewController = navigationController.topViewController as! ReplyViewController
            replyViewController.tweet = self.tweet
        }
    }
    
}
