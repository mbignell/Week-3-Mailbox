//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Margaret Bignell on 9/30/15.
//  Copyright © 2015 maggled. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    
    @IBOutlet weak var navigationView: UIView!
    
    @IBOutlet weak var helpMeText: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchBox: UIButton!
    @IBOutlet weak var searchText: UIButton!
    @IBOutlet weak var searchView: UIView!
    var searchViewOriginalCenter: CGPoint!
    var searchBoxOriginalCenter: CGPoint!
    var searchTextOriginalCenter: CGPoint!
    var searchBoxOriginalWidth = CGFloat()

    
    @IBOutlet weak var archivedItems: UIImageView!
    var archivedItemsOriginalCenter: CGPoint!
    
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var message: UIImageView!
    var messageOriginalCenter: CGPoint!
    var scrollViewOriginalCenter: CGPoint!
    
    let mailboxColor = UIColor(red:0.45, green:0.77, blue:0.87, alpha:1.0)
    let archiveColor = UIColor(red:0.45, green:0.84, blue:0.41, alpha:1.0)
    let laterColor = UIColor(red:0.98, green:0.82, blue:0.27, alpha:1.0)
    let deleteColor = UIColor(red:0.91, green:0.33, blue:0.23, alpha:1.0)
    let listColor = UIColor(red:0.84, green:0.65, blue:0.47, alpha:1.0)
    let greyColor = UIColor(red:0.91, green:0.92, blue:0.93, alpha:1.0)
    
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var leftIcons: UIView!
    var leftIconsOriginalCenter: CGPoint!

    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var ListIcon: UIImageView!
    @IBOutlet weak var rightIcons: UIView!
    var rightIconsOriginalCenter: CGPoint!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setting up scroll view
        scrollView.contentSize = CGSize(width: 320, height: 2060)
        scrollViewOriginalCenter = scrollView.center
        
        //portions of the animated message
        messageOriginalCenter = message.center
        messageContainer.backgroundColor = self.greyColor
        
            //left icons
            leftIconsOriginalCenter = leftIcons.center
            archiveIcon.alpha = 1
            deleteIcon.alpha = 0
            leftIcons.alpha = 0.5
        
            //right icons
            rightIconsOriginalCenter = rightIcons.center
            laterIcon.alpha = 1
            ListIcon.alpha = 0
        
        //archive tab
        archivedItemsOriginalCenter = archivedItems.center
        archivedItems.center.x = archivedItemsOriginalCenter.x + 320
        
        
        //search box
        searchViewOriginalCenter = searchView.center
        searchBoxOriginalCenter = searchBox.center
        searchTextOriginalCenter = searchText.center
        searchBox.layer.cornerRadius = 8.0
        searchBox.clipsToBounds = true
    }

    @IBAction func onEmailPan(sender: AnyObject) {
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        
//        print("panned yo to \(location) which emans")
        
        if sender.state == UIGestureRecognizerState.Began {
            print("began")
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            print("changed \(translation)")
            //if translation > 60 then background is one color
            
            //if translation is > 240 another color
            
            //other side (negative translation)
            message.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
            if translation.x >= 35 {
                leftIcons.alpha = 1
            }
            
            if translation.x >= 60 {
                leftIcons.center = CGPoint(x: leftIconsOriginalCenter.x + translation.x - 60, y: leftIconsOriginalCenter.y)
            } else if translation.x <= -60 {
                rightIcons.center = CGPoint(x: rightIconsOriginalCenter.x + translation.x + 60, y: rightIconsOriginalCenter.y)
            }
            
            if translation.x >= 50 && translation.x <= 219 {
                rightIcons.alpha = 0
                leftIcons.alpha = 1

                UIView.animateWithDuration(0.2, animations: {
                self.messageContainer.backgroundColor = self.archiveColor
                self.deleteIcon.alpha = 0
                self.archiveIcon.alpha = 1
            
                })
            } else if translation.x >= 220 {
                rightIcons.alpha = 0
                leftIcons.alpha = 1

                UIView.animateWithDuration(0.2, animations: {
                self.messageContainer.backgroundColor = self.deleteColor
                self.archiveIcon.alpha = 0
                self.deleteIcon.alpha = 1
                
                })
            } else if translation.x <= -40 && translation.x >= -219 {
                rightIcons.alpha = 1
                leftIcons.alpha = 0
                messageContainer.backgroundColor = laterColor
            }else if translation.x <= -220 {
                rightIcons.alpha = 1
                leftIcons.alpha = 0
                messageContainer.backgroundColor = listColor
            }
            else if translation.x < 60 && translation.x > -60 {
                leftIcons.center = leftIconsOriginalCenter
                self.messageContainer.backgroundColor = self.greyColor
                UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: [], animations: ({
                    self.archiveIcon.alpha = 0
                }), completion: nil)
              
            }

        }
        else if sender.state == UIGestureRecognizerState.Ended {
            print("ended")
            //if translation is >240 >60 etc, then d
            
            //if translation is yellow read later, then pop up modal thing (and keep velocity to send off screen
            //if they tap out of modal thing, then bounce the email back into place
            //if they choose one, highlight, whole bar is yellow,
            
            //if list view, full modal above
            if translation.x < 60 && translation.x > -60 {
                message.center = messageOriginalCenter
            } else if translation.x >= 60 {
                UIView.animateWithDuration(0.1, animations: {
                self.message.center.x = self.messageOriginalCenter.x + 320
                })
                 leftIcons.center = CGPoint(x: leftIconsOriginalCenter.x + translation.x - 60, y: leftIconsOriginalCenter.y)
            } else if translation.x <= -60 {
                UIView.animateWithDuration(0.1, animations: {
                    self.message.center.x = self.messageOriginalCenter.x - 320
                })
            }
        }

    }
    
    //switching between tabs

    @IBAction func onSegmentedControlTap(sender: AnyObject) {
        
        //verify working
        print("segmented control change")
        
        
        //if the selected control is archive, move scroll view over, move archive items in, and change color of icons on top nav 
        //need to figure out: how to properly move images so that we know where we're coming from (and it adjusts/animates properly)
        //need to make icons for top nav such that I can change the tint color on them

        if segmentedControl.selectedSegmentIndex == 2 {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.scrollView.center = CGPoint(x: self.scrollViewOriginalCenter.x - 320, y: self.scrollViewOriginalCenter.y)
            self.archivedItems.center.x = self.archivedItemsOriginalCenter.x
            self.segmentedControl?.tintColor = self.archiveColor
            }
        } else if segmentedControl.selectedSegmentIndex == 0 {
            
            //if segmented control is later, change to later color
            //be able to animate further
            self.segmentedControl?.tintColor = self.laterColor
            
        } else {
            self.segmentedControl?.tintColor = self.mailboxColor
        }
    }
    
    @IBAction func onSearchButtonTap(sender: AnyObject) {
        print("search button tapped")
        searchView.center.y = searchViewOriginalCenter.y - 50
    }
    
    @IBAction func onSearchBoxTap(sender: AnyObject) {
        print("testing search box")
        UIView.animateWithDuration(0.4) { () -> Void in
            self.searchView.center.y = self.searchViewOriginalCenter.y - 0
            self.searchView.center.x = self.searchViewOriginalCenter.x - 30
            self.helpMeText.alpha = 0
            self.navigationView.alpha = 0
            self.scrollView.center.y = self.scrollViewOriginalCenter.y - 80
            self.searchText.center.x = self.searchViewOriginalCenter.x - 70
            self.searchBox.transform = CGAffineTransformMakeScale(0.8, 1)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
