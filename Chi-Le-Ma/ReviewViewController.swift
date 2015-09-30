//
//  ReviewViewController.swift
//  Chi-Le-Ma
//
//  Created by Chris Kong on 9/30/15.
//  Copyright © 2015 Chris Kong. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController
{
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var ratingStackView: UIStackView!
  var rating: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    backgroundImageView.addSubview(blurEffectView)
    
    // ratingStackView.transform = CGAffineTransformMakeScale(0.0, 0.0)
    // ratingStackView.transform = CGAffineTransformMakeScale(0.0, 500.0)
    let scale = CGAffineTransformMakeScale(0.0, 0.0)
    let translate = CGAffineTransformMakeTranslation(0, 500)
    ratingStackView.transform = CGAffineTransformConcat(scale, translate)
  }
  
  override func viewDidAppear(animated: Bool)
  {
//    UIView.animateWithDuration(0.4, delay: 0.0, options: [], animations: {
//      self.ratingStackView.transform = CGAffineTransformIdentity
//    }, completion: nil)
    UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
      self.ratingStackView.transform = CGAffineTransformIdentity
    }, completion: nil)
    
  }
  
  @IBAction func ratingSelected(sender: UIButton)
  {
    switch (sender.tag)
    {
      case 100: rating = "dislike"
      case 200: rating = "good"
      case 300: rating = "great"
      default: break
    }
    performSegueWithIdentifier("unwindToDetailView", sender: sender)
  }
  

}