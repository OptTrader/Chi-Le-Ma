
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
  
  var restaurant: Restaurant!
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return 4
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
      cell.fieldLabel.text = "Been here"
      cell.valueLabel.text = (restaurant.isVisited) ? "Yes, I've been here before" : "No"
    default:
      cell.fieldLabel.text = ""
      cell.valueLabel.text = ""
    }
    return cell
  }
  

}