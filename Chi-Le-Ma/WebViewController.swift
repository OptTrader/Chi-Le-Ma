//
//  WebViewController.swift
//  Chi-Le-Ma
//
//  Created by Chris Kong on 10/8/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit

class WebViewController: UIViewController
{
  @IBOutlet weak var webView: UIWebView!
 
  override func viewDidLoad() {
    super.viewDidLoad()

    if let url = NSURL(string: "http://chrisjkong.com")
    {
      let request = NSURLRequest(URL: url)
      webView.loadRequest(request)
    }
  }

  
}