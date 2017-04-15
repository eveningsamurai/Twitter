//
//  LoginViewController.swift
//  Twitter
//
//  Created by Padmanabhan, Avinash on 4/13/17.
//  Copyright © 2017 Intuit. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        TwitterClient.sharedInstance.login(success: {
            print("logged in successfully")            
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }) { (error: Error) in
            print("error with logging in: \(error.localizedDescription)")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
