//
//  USHViewController.swift
//  Jamz
//
//  Created by Jimmy Nguyen on 1/28/16.
//  Copyright © 2016 Jimmy Nguyen. All rights reserved.
//

import UIKit

class USHViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    var searches = [UserSearchHistory]()
    var searchController = UISearchController(searchResultsController: nil)
    var filteredSearches = [UserSearchHistory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        print("View did load searches", searches)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Fill for each cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        // dequeue cell from storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchHistoryCell")!
        
        // set search variable represent an instance of a USH
        let search: UserSearchHistory
        
        // check to see if user is using the search bar
        // set search variable to represent objects of USH in each index of array
        if searchController.active && searchController.searchBar.text != "" {
            // use filterNotes if search is taking place
            search = filteredSearches[indexPath.row]
        } else {
            // else print out all the searches
            search = searches[indexPath.row]
        }
        
        
        // set entry and date label in each cell
        cell.textLabel!.text = search.item

        
        // return a UITableViewCell
        return cell
    }
    
    // Number of rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searches = UserSearchHistory.all()
        
        if searchController.active && searchController.searchBar.text != "" {
            return filteredSearches.count
        }
        
        return searches.count
    }
    
    // create the action for the accessory button pressed
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print("ready to play music")
        
        performSegueWithIdentifier("PlayMusicSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    // Prepare the segue to pass data to the play music controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PlayMusicSegue" {
            let controller = segue.destinationViewController as! PlayerViewController
   
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.requestToPlay = searches[indexPath.row]
            }
            
        }
    }
    
    // Implementing the SWIPE TO DELETE function
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        searches[indexPath.row].destroy()
        searches.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        tableView.reloadData()
    }
    
    // SEARCH BAR FUNCTIONS
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredSearches = searches.filter { search in
            return search.item.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    
    
}