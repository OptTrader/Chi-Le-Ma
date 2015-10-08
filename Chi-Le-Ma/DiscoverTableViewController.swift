//
//  DiscoverTableViewController.swift
//  Chi-Le-Ma
//
//  Created by Chris Kong on 10/8/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit
import CloudKit

class DiscoverTableViewController: UITableViewController
{
  @IBOutlet var spinner: UIActivityIndicatorView!
  
  var restaurants: [CKRecord] = []
  var imageCache: NSCache = NSCache()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    spinner.hidesWhenStopped = true
    spinner.center = view.center
    view.addSubview(spinner)
    spinner.startAnimating()
    
    getRecordsFromCloud()
    
    // Pull To Refresh Control
    refreshControl = UIRefreshControl()
    refreshControl?.backgroundColor = UIColor.whiteColor()
    refreshControl?.tintColor = UIColor.grayColor()
    refreshControl?.addTarget(self, action: "getRecordsFromCloud", forControlEvents: UIControlEvents.ValueChanged)
  }

  // MARK: - Methods
  
  func getRecordsFromCloud()
  {
    // Fetch data using Convenience API
    let cloudContainer = CKContainer.defaultContainer()
    let publicDatabase = cloudContainer.publicCloudDatabase
    let predicate = NSPredicate(value: true)
    let query = CKQuery(recordType: "Restaurant", predicate: predicate)
    query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    
    // Create the query operation with query
    let queryOperation = CKQueryOperation(query: query)
    queryOperation.desiredKeys = ["name"]
    queryOperation.queuePriority = .VeryHigh
    queryOperation.resultsLimit = 50
    queryOperation.recordFetchedBlock = { (record: CKRecord!) -> Void in
      if let restaurantRecord = record
      {
        self.restaurants.append(restaurantRecord)
      }
    }
    
    queryOperation.queryCompletionBlock = { (cursor: CKQueryCursor?, error: NSError?) -> Void in
      if (error != nil)
      {
        print("Failed to get data from iCloud - \(error!.localizedDescription)")
        return
      }
      
      print("Successfully retrieve the data from iCloud")
      self.refreshControl?.endRefreshing()
      NSOperationQueue.mainQueue().addOperationWithBlock()
        {
          self.spinner.stopAnimating()
          self.tableView.reloadData()
      }
    }
    
    // Execute the query
    publicDatabase.addOperation(queryOperation)
  }
  
  // MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return restaurants.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    
    // Configure the cell
    let restaurant = restaurants[indexPath.row]
    cell.textLabel?.text = restaurant.objectForKey("name") as? String
    
    // Set the default image
    cell.imageView?.image = UIImage(named: "photoalbum")
    
    // Check if the image is stored in cache
    if let imageFileURL = imageCache.objectForKey(restaurant.recordID) as? NSURL
    {
      // Fetch image from cache
      print("Get image from cache")
      cell.imageView?.image = UIImage(data: NSData(contentsOfURL: imageFileURL)!)
    
    } else {
      
      // Fetch Image from Cloud in background
      let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
      let fetchRecordsImageOperation = CKFetchRecordsOperation(recordIDs: [restaurant.recordID])
      fetchRecordsImageOperation.desiredKeys = ["image"]
      fetchRecordsImageOperation.queuePriority = .VeryHigh
    
      fetchRecordsImageOperation.perRecordCompletionBlock = { (record: CKRecord?, recordID: CKRecordID?, error: NSError?) -> Void in
        if (error != nil)
        {
          print("Failed to get data from iCloud - \(error!.localizedDescription)")
          return
        }
        
        if let restaurantRecord = record
        {
          NSOperationQueue.mainQueue().addOperationWithBlock()
          {
            if let imageAsset = restaurantRecord.objectForKey("image") as? CKAsset
            {
              cell.imageView?.image = UIImage(data: NSData(contentsOfURL: imageAsset.fileURL)!)
              
              // Add the image URL to cache
              self.imageCache.setObject(imageAsset.fileURL, forKey: restaurant.recordID)
            }
          }
        }
      }
     
      publicDatabase.addOperation(fetchRecordsImageOperation)
    }
    
    return cell
  }


  
}