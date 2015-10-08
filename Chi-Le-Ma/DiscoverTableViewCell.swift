//
//  DiscoverTableViewCell.swift
//  Chi-Le-Ma
//
//  Created by Chris Kong on 10/8/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell
{
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var bgImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }

}