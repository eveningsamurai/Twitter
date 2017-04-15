//
//  User.swift
//  Twitter
//
//  Created by Padmanabhan, Avinash on 4/13/17.
//  Copyright © 2017 Intuit. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileUrl: URL?
    var userDescription: String?
    var userDict: NSDictionary?
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    init(user: NSDictionary) {
        self.userDict = user
        
        self.name = user["name"] as? String
        self.screenName = user["screen_name"] as? String
        
        let profileUrlString = user["profile_image_https_url"] as? String
        if let profileUrlString = profileUrlString {
            self.profileUrl = URL(string: profileUrlString)
        }
        
        self.userDescription = user["description"] as? String
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData {
                    let dict = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(user: dict)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            
            //serialize user json
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.userDict!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
}
