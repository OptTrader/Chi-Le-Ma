//
//  RestaurantTableViewController.swift
//  Chi-Le-Ma
//
//  Created by Chris Kong on 9/29/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController
{
  var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "Thai Cafe"]
  
  var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg", "cafeloisl.jpg", "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg", "bourkestreetbakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg", "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg", "fiveleaves.jpg", "cafelore.jpg", "confessional.jpg", "barrafina.jpg", "donostia.jpg", "royaloak.jpg", "thaicafe.jpg"]
  
  var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
  
  var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Casual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
  
  var restaurantIsVisited = [Bool](count: 21, repeatedValue: false)
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return restaurantNames.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
    
    // configure the cell
    cell.nameLabel.text = restaurantNames[indexPath.row]
    cell.locationLabel.text = restaurantLocations[indexPath.row]
    cell.typeLabel.text = restaurantTypes[indexPath.row]
    cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
    
    cell.accessoryType = restaurantIsVisited[indexPath.row] ? .Checkmark : .None
    
    return cell
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    // Create an option menu as an action sheet
    let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .ActionSheet)
    
    // Add actions to the menu
    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
    optionMenu.addAction(cancelAction)
    
    let callActionHandler = { (action: UIAlertAction!) -> Void in
      
      let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .Alert)
      alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
      self.presentViewController(alertMessage, animated: true, completion: nil)
    }
    
    let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: UIAlertActionStyle.Default, handler: callActionHandler)
    optionMenu.addAction(callAction)
    
    let isVisitedTitle = (restaurantIsVisited[indexPath.row]) ? "I've not been here" : "I've been here"
    let isVisitedAction = UIAlertAction(title: isVisitedTitle, style: .Default, handler: {
        (action: UIAlertAction!) -> Void in
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
      self.restaurantIsVisited[indexPath.row] = (self.restaurantIsVisited[indexPath.row]) ? false : true
      cell?.accessoryType = (self.restaurantIsVisited[indexPath.row]) ? .Checkmark : .None
      })
    optionMenu.addAction(isVisitedAction)
 
    // Display the menu
    self.presentViewController(optionMenu, animated: true, completion: nil)
    
    tableView.deselectRowAtIndexPath(indexPath, animated: false)
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
  {
    if editingStyle == .Delete
    {
      // Delete the row from the data source
      restaurantNames.removeAtIndex(indexPath.row)
      restaurantLocations.removeAtIndex(indexPath.row)
      restaurantTypes.removeAtIndex(indexPath.row)
      restaurantImages.removeAtIndex(indexPath.row)
      restaurantIsVisited.removeAtIndex(indexPath.row)
    }
    
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    
  }
 
  override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
  {
    // Social Sharing Button
    let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: { (action, indexPath) -> Void in
      
      let defaultText = "Just checking in at " + self.restaurantNames[indexPath.row]
      if let imageToShare = UIImage(named: self.restaurantImages[indexPath.row])
      {
        let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)
      }
    })
    
    // Delete button
    let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: { (action, indexPath) -> Void in
      
      // Delete the row from the data source
      self.restaurantNames.removeAtIndex(indexPath.row)
      self.restaurantLocations.removeAtIndex(indexPath.row)
      self.restaurantTypes.removeAtIndex(indexPath.row)
      self.restaurantImages.removeAtIndex(indexPath.row)
      self.restaurantIsVisited.removeAtIndex(indexPath.row)
     
      self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    })
    
    shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
    deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
    
    return [deleteAction, shareAction]
  }
  
  
  
  
  
  
  
}