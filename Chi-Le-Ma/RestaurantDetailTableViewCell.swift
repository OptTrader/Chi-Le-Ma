//
//  RestaurantDetailTableViewCell.swift
//  Chi-Le-Ma
//
//  Created by Chris Kong on 9/30/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit

class RestaurantDetailTableViewCell: UITableViewCell {
  
  @IBOutlet weak var fieldLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}