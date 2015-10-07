//
//  RestaurantTableViewController.swift
//  Chi-Le-Ma
//
//  Created by Chris Kong on 9/29/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating
{
  var restaurants:[Restaurant] = []
  var fetchResultController: NSFetchedResultsController!
  var searchController: UISearchController!
  var searchResults: [Restaurant] = []
  
//    Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phoneNumber: "232-923423", image: "cafedeadend.jpg", isVisited: false),
//    Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", phoneNumber: "348-233423", image: "homei.jpg", isVisited: false),
//    Restaurant(name: "Teakha", type: "Tea House", location: "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phoneNumber: "354-243523", image: "teakha.jpg", isVisited: false),
//    Restaurant(name: "Cafe loisl", type: "Austrian / Casual Drink", location: "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phoneNumber: "453-333423", image: "cafeloisl.jpg", isVisited: false),
//    Restaurant(name: "Petite Oyster", type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phoneNumber: "983-284334", image: "petiteoyster.jpg", isVisited: false),
//    Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", phoneNumber: "232-434222", image: "forkeerestaurant.jpg", isVisited: false),
//    Restaurant(name: "Po's Atelier", type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", phoneNumber: "234-834322", image: "posatelier.jpg", isVisited: false),
//    Restaurant(name: "Bourke Street Bakery", type: "Chocolate", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", phoneNumber: "982-434343", image: "bourkestreetbakery.jpg", isVisited: false),
//    Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney New South Wales", phoneNumber: "734-232323", image: "haighschocolate.jpg", isVisited: false),
//    Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Shop 1 61 York St Sydney New South Wales", phoneNumber: "872-734343", image: "palominoespresso.jpg", isVisited: false),
//    Restaurant(name: "Upstate", type: "American", location: "95 1st Ave New York, NY 10003", phoneNumber: "343-233221", image: "upstate.jpg", isVisited: false),
//    Restaurant(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY 11211", phoneNumber: "985-723623", image: "traif.jpg", isVisited: false),
//    Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "445 Graham Ave Brooklyn, NY 11211", phoneNumber: "455-232345", image: "grahamavenuemeats.jpg", isVisited: false),
//    Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave Brooklyn, NY 11211", phoneNumber: "434-232322", image: "wafflewolf.jpg", isVisited: false),
//    Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "18 Bedford Ave Brooklyn, NY 11222", phoneNumber: "343-234553", image: "fiveleaves.jpg", isVisited: false),
//    Restaurant(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", phoneNumber: "342-455433", image: "cafelore.jpg", isVisited: false),
//    Restaurant(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY 10003", phoneNumber: "643-332323", image: "confessional.jpg", isVisited: false),
//    Restaurant(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D 4SL United Kingdom", phoneNumber: "542-343434", image: "barrafina.jpg", isVisited: false),
//    Restaurant(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H 7ND United Kingdom", phoneNumber: "722-232323", image: "donostia.jpg", isVisited: false),
//    Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", phoneNumber: "343-988834", image: "royaloak.jpg", isVisited: false),
//    Restaurant(name: "Thai Cafe", type: "Thai", location: "22 Charlwood Street London SW1V 2DY Pimlico", phoneNumber: "432-344050", image: "thaicafe.jpg", isVisited: false)
//  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Remove the title of the back button
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    
    // Enable self sizing cells
    tableView.estimatedRowHeight = 36.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    // Fetch request
    let fetchRequest = NSFetchRequest(entityName: "Restaurant")
    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    {
      fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
      fetchResultController.delegate = self
      
      do {
        try fetchResultController.performFetch()
        restaurants = fetchResultController.fetchedObjects as! [Restaurant]
      } catch {
        print(error)
      }
    }
    
    // Adding a search bar
    searchController = UISearchController(searchResultsController: nil)
    tableView.tableHeaderView = searchController.searchBar
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    
    // Customize the appearance of the search bar
    searchController.searchBar.placeholder = "Search restaurants..."
    searchController.searchBar.tintColor = UIColor.whiteColor()
    searchController.searchBar.barTintColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let hasViewedWalkthrough = defaults.boolForKey("hasViewedWalkthrough")
    
    if hasViewedWalkthrough
    {
      return
    }
  
    if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughController") as? WalkthroughPageViewController
    {
      presentViewController(pageViewController, animated: true, completion: nil)
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.hidesBarsOnSwipe = true
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    if searchController.active
    {
      return searchResults.count
      
    } else {
      return restaurants.count
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
    
    // configure for search bar
    let restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
    
    // configure the cell
    cell.nameLabel.text = restaurant.name
    cell.locationLabel.text = restaurant.location
    cell.typeLabel.text = restaurant.type
    cell.thumbnailImageView.image = UIImage(data: restaurant.image!)
    
    if let isVisited = restaurant.isVisited?.boolValue
    {
      cell.accessoryType = isVisited ? .Checkmark : .None
    }
    
    return cell
  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
  {
    if editingStyle == .Delete
    {
      // Delete the row from the data source
      restaurants.removeAtIndex(indexPath.row)
    }
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
  }
 
  override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
  {
    // Social Sharing Button
    let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: { (action, indexPath) -> Void in
      
      let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
      if let imageToShare = UIImage(data: self.restaurants[indexPath.row].image!)
      {
        let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)
      }
    })
    
    // Delete button
    let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: { (action, indexPath) -> Void in
      
      // Delete the row from the database
      if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
      {
        let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
        managedObjectContext.deleteObject(restaurantToDelete)
        
        do {
          try managedObjectContext.save()
        } catch {
          print(error)
        }
      }
    })
    
    // Set the button color
    shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
    deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
    
    return [deleteAction, shareAction]
  }
  
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
  {
    if searchController.active
    {
      return false
      
    } else {
      return true
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  {
    if segue.identifier == "showRestaurantDetail"
    {
      if let indexPath = tableView.indexPathForSelectedRow
      {
        let destinationController = segue.destinationViewController as! RestaurantDetailViewController
        destinationController.restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
      }
    }
  }
  
  @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue)
  {
  }
  
  // MARK: - NSFetchedResultsControllerDelegate
  
  func controllerWillChangeContent(controller: NSFetchedResultsController)
  {
    tableView.beginUpdates()
  }
  
  func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?)
  {
    switch type
    {
      case .Insert:
        if let _newIndexPath = newIndexPath
        {
          tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
        }
      case .Delete:
        if let _indexPath = indexPath
        {
          tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
        }
      case .Update:
        if let _indexPath = indexPath
        {
          tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
        }
      default:
        tableView.reloadData()
    }
    restaurants = controller.fetchedObjects as! [Restaurant]
  }
  
  func controllerDidChangeContent(controller: NSFetchedResultsController)
  {
    tableView.endUpdates()
  }
  
  // MARK: - Search
  
  func updateSearchResultsForSearchController(searchController: UISearchController)
  {
    if let searchText = searchController.searchBar.text
    {
      filterContentForSearchText(searchText)
      tableView.reloadData()
    }
  }
  
  func filterContentForSearchText(searchText: String)
  {
    searchResults = restaurants.filter({ (restaurant: Restaurant) -> Bool in
      let nameMatch = restaurant.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
      let locationMatch = restaurant.location.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
      
      return nameMatch != nil || locationMatch != nil
    })
  }
  
}