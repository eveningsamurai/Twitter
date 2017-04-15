//
//  TwitterClient.swift
//  Twitter
//
//  Created by Padmanabhan, Avinash on 4/14/17.
//  Copyright © 2017 Intuit. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "s8524l4gwyiteBMc8wPIvPfxg", consumerSecret: "XdTDxN6Ksl5ffKp5kRs0ndaEr7DGwLoOfXJE5rIM2lJXA9XCEY")!
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        //get the request token
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string:"apTwitterDemo://oauth"), scope: nil,
            success: { (requestToken: BDBOAuth1Credential?) in
                print("Got the request token!")
                                            
                //allow safari to open the redirect link
                if let token = requestToken?.token {
                    let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")!
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            },
            failure: { (error: Error?) in
                print("Error: \(error?.localizedDescription)")
                self.loginFailure?(error!)
            }
        )
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        deauthorize()
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken,
            success: { (accessToken: BDBOAuth1Credential?) in
                self.currentAccount(
                    success: { (user: User) in
                        User.currentUser = user
                        self.loginSuccess?()
                    },
                    failure: { (error: Error) in
                        print("error: \(error.localizedDescription)")
                        self.loginFailure?(error)
                    }
                )
            },
            failure: { (error: Error?) in
                print("Was unable to get access token: \(error?.localizedDescription)")
                self.loginFailure?(error!)
            }
        )
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil,
            success: { (task: URLSessionDataTask, response: Any?) in
                let tweetsDictArr = response as! [NSDictionary]
                let tweets = Tweet.getTweetsArray(dicts: tweetsDictArr)
                success(tweets)
            },
            
            failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
            }
        )
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil,
            success: { (task: URLSessionDataTask, response: Any?) in
                let userDict = response as! NSDictionary
                let user = User(user: userDict)
                
                success(user)
            },
            failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
            }
        )
    }
}
