//
//  DetailsViewController.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/4/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scientificNameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var desciptionLabel: UILabel!
    @IBOutlet weak var otherNotesLabel: UILabel!
    @IBOutlet weak var noOfCapsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // The passed drug
    var drug: Drug!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = drug.name
        
        self.nameLabel.text = drug.name
        self.scientificNameLabel.text = drug.scientificName
        self.companyLabel.text = drug.cc_by
        self.desciptionLabel.text = drug.desciption
        self.otherNotesLabel.text = drug.notes
        self.noOfCapsLabel.text = "\(drug.numberOfCaps)"
        self.priceLabel.text = "\(drug.price)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.hidesBarsOnSwipe = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    //MARK: Segue
    @IBAction func close(segue: UIStoryboardSegue) {}
    
    
}
