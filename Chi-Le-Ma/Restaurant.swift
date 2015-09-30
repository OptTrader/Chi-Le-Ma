
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
  var phoneNumber = ""
  var image = ""
  var isVisited = false
  var rating = ""
  
  init(name: String, type: String, location: String, phoneNumber: String, image: String, isVisited: Bool)
  {
    self.name = name
    self.type = type
    self.location = location
    self.phoneNumber = phoneNumber
    self.image = image
    self.isVisited = isVisited
  }
  
}