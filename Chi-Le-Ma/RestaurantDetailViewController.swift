
//
//  RestaurantDetailViewController.swift
//  Chi-Le-Ma
//
//  Created by Chris Kong on 9/30/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController
{
  @IBOutlet weak var restaurantNameLabel: UILabel!
  @IBOutlet weak var restaurantLocationLabel: UILabel!
  @IBOutlet weak var restaurantTypeLabel: UILabel!
  @IBOutlet weak var restaurantImageView: UIImageView!
  
  var name = ""
  var location = ""
  var type = ""
  var restaurantImage = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    restaurantNameLabel.text = name
    restaurantLocationLabel.text = location
    restaurantTypeLabel.text = type
    restaurantImageView.image = UIImage(named: restaurantImage)
  }

}