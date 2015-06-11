//
//  DrugsTableViewController.swift
//  HealthCareProject
//
//  Created by Ahmad Ayman on 5/4/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit
import CoreData

class DrugsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    var fetchedResultController: NSFetchedResultsController!
    var searchController: UISearchController!
    var localDrugs: [Drug] = []
    var searchResult: [Drug] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        
        // Polish the tableView UI
        tableView.backgroundColor =  UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0,alpha: 1)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        //tableView.tableFooterView = UIView(frame: CGRectZero)  // Remove the footer with blank view
       
        // Fetching the data from CoreData
        var fetchRequest = NSFetchRequest(entityName: "Drug")
        var sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        {
            fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultController.delegate = self
            var e: NSError?
            var result = fetchedResultController.performFetch(&e)
            localDrugs = fetchedResultController.fetchedObjects as! [Drug]
            if result != true
            {
                println(e!.localizedDescription)
            }
        }
        
        //Seach Controller
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchResultsUpdater = self        // Delegate
        searchController.dimsBackgroundDuringPresentation = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
            return searchResult.count
        }
        else {
            return localDrugs.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let drug = (searchController.active) ? searchResult[indexPath.row] : localDrugs[indexPath.row]
        cell.textLabel?.text = drug.name
        cell.textLabel?.font = UIFont(name: "Avenir-Heavy", size: 18.0)
    
        return cell
    }


    //MARK: NSFetchResultCotroller Delegate Methods
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        localDrugs = controller.fetchedObjects as! [Drug]
        
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
    
    //MARK: Search Methods
    func filterContentForSearchText(searchText: String)
    {
        searchResult = localDrugs.filter({ (drug: Drug) -> Bool in
            let nameMatch = drug.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            let scientificNameMatch = drug.scientificName.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            return ( nameMatch != nil || scientificNameMatch != nil )
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    
    //MARK: Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDrugDetailsSegue" {
            if let indexPath = tableView.indexPathForSelectedRow() {
                if let dvc = segue.destinationViewController as? DetailsViewController {
                    dvc.drug = (searchController.active) ? searchResult[indexPath.row] : localDrugs[indexPath.row]
                }
            }
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {}
}