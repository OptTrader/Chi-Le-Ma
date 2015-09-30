
//
//  Restaurant.swift
//  Chi-Le-Ma
//
//  Created by Chris Kong on 9/30/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import Foundation

class Restaurant
{
  var name = ""
  var type = ""
  var location = ""
  var image = ""
  var isVisited = false
  
  init(name: String, type: String, location: String, image: String, isVisited: Bool)
  {
    self.name = name
    self.type = type
    self.location = location
    self.image = image
    self.isVisited = isVisited
  }
  
  
}