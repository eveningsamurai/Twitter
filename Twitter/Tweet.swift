//
//  Tweet.swift
//  Twitter
//
//  Created by Padmanabhan, Avinash on 4/13/17.
//  Copyright © 2017 Intuit. All rights reserved.
//

import Foundation

class Tweet: NSObject {
    
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(tweetDict: NSDictionary) {
        self.text = tweetDict["text"] as? String
        
        let createdAtString = tweetDict["created_at"] as? String
        if let createdAtString = createdAtString {
            let dateFormatter = DateFormatter()
            //Tue Aug 28 21:16:23 +0000 2012
            dateFormatter.dateFormat = "EEEE MMM d HH:mm:ss Z yyyy"
            self.timestamp = dateFormatter.date(from: createdAtString) as NSDate?
        }
        
        self.retweetCount = (tweetDict["retweet_count"] as? Int) ?? 0
        self.favoritesCount = (tweetDict["favourites_count"] as? Int) ?? 0
    }
    
    //get the complete list of tweets
    class func getTweetsArray(dicts: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dict in dicts {
            tweets.append(Tweet(tweetDict: dict))
        }
        return tweets
    }
}
