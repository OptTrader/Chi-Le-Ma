//
//  AddRestaurantViewController.swift
//  Chi-Le-Ma
//
//  Created by Chris Kong on 10/1/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var typeTextField: UITextField!
  @IBOutlet weak var locationTextField: UITextField!
  @IBOutlet weak var phoneNumberTextField: UITextField!
  @IBOutlet weak var yesButton: UIButton!
  @IBOutlet weak var noButton: UIButton!
  
  var restaurant: Restaurant!
  var isVisited = true
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    if indexPath.row == 0
    {
      if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary)
      {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
      }
    }
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
  {
    imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    imageView.contentMode = UIViewContentMode.ScaleAspectFill
    imageView.clipsToBounds = true
    
    let leadingConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
    leadingConstraint.active = true
    
    let trailingConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
    trailingConstraint.active = true
    
    let topConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
    topConstraint.active = true
    
    let bottomConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
    bottomConstraint.active = true

    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: - Action methods
  
  @IBAction func saveAction(sender: UIBarButtonItem)
  {
    let name = nameTextField.text
    let type = typeTextField.text
    let location = locationTextField.text
    let phoneNumber = phoneNumberTextField.text
    
    // Validate input fields
    if name == "" || type == "" || location == ""
    {
      let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: UIAlertControllerStyle.Alert)
      alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alertController, animated: true, completion: nil)
      return
    }
    
    if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    {
      restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
      restaurant.name = name!
      restaurant.type = type!
      restaurant.location = location!
      restaurant.phoneNumber = phoneNumber!
      if let restaurantImage = imageView.image
      {
        restaurant.image = UIImagePNGRepresentation(restaurantImage)
      }
      restaurant.isVisited = isVisited
      do {
        try managedObjectContext.save()
      } catch {
        print(error)
        return
      }
    }
  
//    // Print input data to console
//    print("Name: \(name)")
//    print("Type: \(type)")
//    print("Locaton: \(location)")
//    print("Have you Been here: \(isVisited)")
//    
    // Dismiss the view controller
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func toggleBeenHereButton(sender: UIButton)
  {
    // Yes button clicked
    if sender == yesButton
    {
      isVisited = true
      yesButton.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
      noButton.backgroundColor = UIColor.grayColor()
      
    } else if sender == noButton
    {
      isVisited = false
      yesButton.backgroundColor = UIColor.grayColor()
      noButton.backgroundColor = UIColor(red: 235.0/255.0, green: 73.0/255.0, blue: 27.0/255.0, alpha: 1.0)
    }
  }
  
  

}

