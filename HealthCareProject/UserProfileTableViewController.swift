//
//  UserProfileTableViewController.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/11/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit
import Parse

class UserProfileTableViewController: UITableViewController {

    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser = PFUser.currentUser()
        let firstname = currentUser?.objectForKey("firstname") as? String
        let lastname = currentUser?.objectForKey("lastname") as? String
        fullNameLabel.text = "Ali Ahmed"
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if PFUser.currentUser() == nil {
            println("Current user is nil")
            self.performSegueWithIdentifier("userLogin", sender: self)
        } else {
            println("A user has been found")
            let user = PFUser.currentUser()!
            println(user.username)
        }
    }
    
    //MARK: Segues
    @IBAction func close(segue: UIStoryboardSegue) { }

}
