//
//  DoctorsTableViewController.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/5/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit
import CoreData

class DoctorsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    var fetchedResultController: NSFetchedResultsController!
    var searchController: UISearchController!
    var doctors: [Doctor] = []
    var searchResult: [Doctor] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        var fetchRequest = NSFetchRequest(entityName: "Doctor")
        var sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        {
            fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultController.delegate = self
            var e: NSError?
            var result = fetchedResultController.performFetch(&e)
            doctors = fetchedResultController.fetchedObjects as! [Doctor]
            if result != true
            {
                println(e!.localizedDescription)
            }
            
            //println("Doctors = \(doctors) And count = \(doctors.count)")
        }
        
        //Seach Controller
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isDoctorLoggedIn")
        
        if !isUserLoggedIn
        {
            //self.performSegueWithIdentifier("doctorLoginSegue", sender: self)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
   

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
            return searchResult.count
        }
        else {
            return doctors.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DoctorsTableViewCell
    
        let doctor = (searchController.active) ? searchResult[indexPath.row] : doctors[indexPath.row]
        
        
        println(doctor.name)
        
        cell.nameLabel.text = doctor.name
        cell.specializationLabel.text = doctor.spectialziation
        cell.locationLabel.text = doctor.location
        //cell.drImage.image = UIImage(data: doctor.image)
        
        //cell.drImage.layer.cornerRadius = cell.drImage.frame.size.width / 2
        //cell.drImage.clipsToBounds = true

        return cell
    }

    //MARK: NSFetchResultCotroller Delegate Methods
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        doctors = controller.fetchedObjects as! [Doctor]
        
        switch type {
        case .Insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        case .Delete:
            if let _indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let _indexPath = indexPath {
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
            
        default:
            tableView.reloadData()
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    //MARK: Segue Methods
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDoctorDetails" {
            if let indexPath = tableView.indexPathForSelectedRow() {
                if let dvc = segue.destinationViewController as? DoctorDetailsViewController {
                    dvc.doctor = (searchController.active) ? searchResult[indexPath.row] : doctors[indexPath.row]
                }
            }
        }
    }

    //MARK: Instance Methods
    func filterContentForSearchText(searchText: String)
    {
        searchResult = doctors.filter({ (doctor: Doctor) -> Bool in
            let nameMatch = doctor.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            let locationMatch = doctor.location.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            let spectializationMatch = doctor.spectialziation.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            return ( nameMatch != nil || locationMatch != nil || spectializationMatch != nil)
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
}
