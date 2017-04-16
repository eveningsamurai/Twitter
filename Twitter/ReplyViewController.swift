//
//  ReplyViewController.swift
//  Twitter
//
//  Created by Padmanabhan, Avinash on 4/15/17.
//  Copyright © 2017 Intuit. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {

    var tweet: Tweet?
    
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var replyNameLabel: UILabel!
    @IBOutlet weak var replyScreenNameLabel: UILabel!
    @IBOutlet weak var replyTweetTextView: UITextView!
    @IBOutlet weak var replyCharactersRemainingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        replyNameLabel.text = tweet?.user?.name
        replyScreenNameLabel.text = tweet?.user?.screenName
        replyImageView.setImageWith((tweet?.user?.profileUrl)!)
        replyTweetTextView.text = "@\(tweet!.user!.screenName!) "
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onTweetButton(_ sender: Any) {
        if let text = replyTweetTextView.text {
            TwitterClient.sharedInstance.replyToTweet(withTweetId: (tweet?.tweetId!)!, andText: text,
                success: { (tweet: Tweet) in
                    let alert = UIAlertController(title: "Reply",
                                                  message: "Reply posted to @\(self.tweet!.user!.screenName!)",
                                                  preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK",
                                                 style: .destructive,
                                                 handler: { (action) in
                                                    self.dismiss(animated: true, completion: nil)
                                                 })
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    print("success in replying to tweet!")
                },
                failure: { (error: Error?) in
                    print("Error replying to tweet: \(error?.localizedDescription)")
                }
            )
        }
        
    }
    
}
