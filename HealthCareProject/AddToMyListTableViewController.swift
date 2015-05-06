//
//  AddToMyListTableViewController.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/5/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit

class AddToMyListTableViewController: UITableViewController {
    
    var cellIsHidden = false
    var indexPath = NSIndexPath(forRow: 2, inSection: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    @IBAction func setAutomaticallySwitchTrigger(sender: AnyObject)
    {
        
    }
    
}
