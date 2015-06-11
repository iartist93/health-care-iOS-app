//
//  EmergencyTableViewController.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/21/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit

class EmergencyTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Polish the tableView UI
        tableView.backgroundColor =  UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0,alpha: 1)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        self.navigationItem.title = "Emergency"
                
    }
}
