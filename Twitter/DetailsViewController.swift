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
    
    @IBOutlet weak var detailProfileImageView: UIImageView!
    @IBOutlet weak var detailProfileNameLabel: UILabel!
    @IBOutlet weak var detailProfileScreenNameLabel: UILabel!
    @IBOutlet weak var detailProfileTweetLabel: UILabel!
    @IBOutlet weak var detailProfileFavoritesLabel: UILabel!
    @IBOutlet weak var detailProfileTimestampLabel: UILabel!
    @IBOutlet weak var detailProfileRetweetsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailProfileTweetLabel.text = tweet?.text
        detailProfileNameLabel.text = tweet?.user?.name
        detailProfileScreenNameLabel.text = tweet?.user?.screenName
        detailProfileImageView.setImageWith((tweet?.user?.profileUrl)!)
        detailProfileRetweetsLabel.text = String(tweet!.retweetCount) + " RETWEETS"
        detailProfileFavoritesLabel.text = String(tweet!.favoritesCount) + " FAVORITES"
        
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

    @IBAction func onReplyButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
