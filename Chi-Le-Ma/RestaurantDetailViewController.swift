
//
//  RestaurantDetailViewController.swift
//  Chi-Le-Ma
//
//  Created by Chris Kong on 9/30/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
  @IBOutlet weak var restaurantImageView: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var ratingButton: UIButton!
  
  var restaurant: Restaurant!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    restaurantImageView.image = UIImage(named: restaurant.image)
    
    // Change the color of the table view
    tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
    
    // Remove the separators of the empty rows
    tableView.tableFooterView = UIView(frame: CGRectZero)
    
    // Change the color of the separator
    tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
    
    // Set the title of the navigation bar
    title = restaurant.name
    
    // Enable self sizing cells
    tableView.estimatedRowHeight = 36.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    // Set the rating of the restaurant
    if restaurant.rating != ""
    {
      ratingButton.setImage(UIImage(named: restaurant.rating), forState: UIControlState.Normal)
    }
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.hidesBarsOnSwipe = false
    navigationController?.setNavigationBarHidden(false, animated: true)
  }

  // MARK: - Table view data source
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return 5
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RestaurantDetailTableViewCell

    // Configure the cell..
    switch indexPath.row {
    case 0:
      cell.fieldLabel.text = "Name"
      cell.valueLabel.text = restaurant.name
    case 1:
      cell.fieldLabel.text = "Type"
      cell.valueLabel.text = restaurant.type
    case 2:
      cell.fieldLabel.text = "Location"
      cell.valueLabel.text = restaurant.location
    case 3:
      cell.fieldLabel.text = "Phone"
      cell.valueLabel.text = restaurant.phoneNumber
    case 4:
      cell.fieldLabel.text = "Been here"
      cell.valueLabel.text = (restaurant.isVisited) ? "Yes, I've been here before" : "No"
    default:
      cell.fieldLabel.text = ""
      cell.valueLabel.text = ""
    }
    cell.backgroundColor = UIColor.clearColor()
    
    return cell
  }
  
  @IBAction func close(segue: UIStoryboardSegue)
  {
    if let reviewViewController = segue.sourceViewController as? ReviewViewController
    {
      if let rating = reviewViewController.rating
      {
        ratingButton.setImage(UIImage(named: rating), forState: UIControlState.Normal)
      }
    }
  }
  

}