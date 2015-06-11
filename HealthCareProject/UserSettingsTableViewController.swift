//
//  UserSettingsTableViewController.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/20/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit
import Parse

class UserSettingsTableViewController: UITableViewController {

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("login", sender: self)
    }
    
    
    
    
    
    
    
    
    
    
    
}
