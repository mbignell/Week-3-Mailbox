//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Margaret Bignell on 9/30/15.
//  Copyright © 2015 maggled. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
   
    //color variables
    let mailboxColor = UIColor(red:0.45, green:0.77, blue:0.87, alpha:1.0)
    let archiveColor = UIColor(red:0.45, green:0.84, blue:0.41, alpha:1.0)
    let laterColor = UIColor(red:0.98, green:0.82, blue:0.27, alpha:1.0)
    let deleteColor = UIColor(red:0.91, green:0.33, blue:0.23, alpha:1.0)
    let listColor = UIColor(red:0.84, green:0.65, blue:0.47, alpha:1.0)
    let greyColor = UIColor(red:0.91, green:0.92, blue:0.93, alpha:1.0)
    
    //whole thing
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentView2: UIView!
    var contentViewOriginalCenter: CGPoint!
    
    //menu
    @IBOutlet weak var menuView: UIImageView!
    var menuViewOriginalCenter: CGPoint!
    
    //nav
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var composeIcon: UIButton!
    @IBOutlet weak var menuIcon: UIButton!
    
    //help text
    @IBOutlet weak var helpMeText: UIButton!
    
    //main view
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImage: UIImageView!
    var feedImageOriginalCenter: CGPoint!


    //message
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var message: UIImageView!
    var messageOriginalCenter: CGPoint!
    var scrollViewOriginalCenter: CGPoint!
    
    //message icons
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var leftIcons: UIView!
    var leftIconsOriginalCenter: CGPoint!

    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var ListIcon: UIImageView!
    @IBOutlet weak var rightIcons: UIView!
    var rightIconsOriginalCenter: CGPoint!
    
    //modals after message chosen
    @IBOutlet weak var rescheduleModal: UIImageView!
    @IBOutlet weak var listModal: UIImageView!
    @IBOutlet weak var modalButton: UIButton!
    
    
    //segmented control/other views
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var archivedItems: UIImageView!
    var archivedItemsOriginalCenter: CGPoint!
    @IBOutlet weak var laterItems: UIImageView!
    var laterItemsOriginalCenter: CGPoint!
    
    //compose
    @IBOutlet weak var composeView: UIView!
    var composeViewOriginalCenter: CGPoint!
    @IBOutlet weak var composeDarken: UIView!
    @IBOutlet weak var toField: UITextField!
    @IBOutlet weak var subjectField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    //search
    @IBOutlet weak var searchBox: UIButton!
    @IBOutlet weak var searchText: UIButton!
    @IBOutlet weak var searchView: UIView!
    var searchViewOriginalCenter: CGPoint!
    var searchBoxOriginalCenter: CGPoint!
    var searchTextOriginalCenter: CGPoint!
    var searchBoxOriginalWidth = CGFloat()
    @IBOutlet weak var searchTextField: UITextField!
    var searchTextFieldOriginalCenter: CGPoint!
    var searchTextFieldOriginalWidth = CGFloat()
    @IBOutlet weak var searchCancel: UIButton!
    var searchCancelOriginalCenter: CGPoint!
    @IBOutlet weak var searchDarken: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuIcon.tintColor = mailboxColor
        composeIcon.tintColor = mailboxColor

        //setting up scroll view
        scrollView.contentSize = CGSize(width: 320, height: 2060)
        scrollViewOriginalCenter = scrollView.center
        feedImageOriginalCenter = feedImage.center
        
        //portions of the animated message
        messageOriginalCenter = message.center
        messageContainer.backgroundColor = self.greyColor
        
            //left icons
            leftIconsOriginalCenter = leftIcons.center
            deleteIcon.alpha = 0
        
            //right icons
            rightIconsOriginalCenter = rightIcons.center
            ListIcon.alpha = 0
        
        //modals
        modalButton.hidden = true
        
        //archive tab
        archivedItemsOriginalCenter = archivedItems.center
        archivedItems.center.x = archivedItemsOriginalCenter.x + 320
        laterItemsOriginalCenter = laterItems.center
        laterItems.center.x = laterItemsOriginalCenter.x - 320
        
        
        //search box
        searchViewOriginalCenter = searchView.center
        searchBoxOriginalCenter = searchBox.center
        searchBox.layer.cornerRadius = 8.0
        searchBox.clipsToBounds = true
        searchTextFieldOriginalCenter = searchTextField.center
        searchCancelOriginalCenter = searchCancel.center
        
        //compose
        composeViewOriginalCenter = composeView.center
        composeDarken.alpha = 0
        
        //menu
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(edgeGesture)
        contentViewOriginalCenter = contentView.center
        menuViewOriginalCenter = menuView.center
        menuView.alpha = 0

    }

    @IBAction func onEmailPan(sender: AnyObject) {
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        
//        print("panned yo to \(location) which emans")
        
        if sender.state == UIGestureRecognizerState.Began {
            print("began")
        } else if sender.state == UIGestureRecognizerState.Changed {
           
            //pick up and move the message
            message.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
            //fade in the icon
            if translation.x <= 60 && translation.x > 0 {
                let alphaChange = convertValue(translation.x, r1Min: 20, r1Max: 60, r2Min: 0, r2Max: 1)
                 leftIcons.alpha = alphaChange
            } else if translation.x >= -60 && translation.x < 0 {
                let alphaChange = convertValue(translation.x, r1Min: -20, r1Max: -60, r2Min: 0, r2Max: 1)
                rightIcons.alpha = alphaChange


            }
            
            //if it is greater than +/- 60, pick up the icon and move it with the message
            if translation.x >= 60 {
                leftIcons.center = CGPoint(x: leftIconsOriginalCenter.x + translation.x - 60, y: leftIconsOriginalCenter.y)
            } else if translation.x <= -60 {
                rightIcons.center = CGPoint(x: rightIconsOriginalCenter.x + translation.x + 60, y: rightIconsOriginalCenter.y)
            }
            
            //archive state
            if translation.x >= 60 && translation.x <= 219 {
                rightIcons.alpha = 0
                leftIcons.alpha = 1

                UIView.animateWithDuration(0.2, animations: {
                self.messageContainer.backgroundColor = self.archiveColor
                self.deleteIcon.alpha = 0
                self.archiveIcon.alpha = 1
            
                })
            }
            //delete state
            else if translation.x >= 220 {
                rightIcons.alpha = 0
                leftIcons.alpha = 1

                UIView.animateWithDuration(0.2, animations: {
                self.messageContainer.backgroundColor = self.deleteColor
                self.archiveIcon.alpha = 0
                self.deleteIcon.alpha = 1
                
                })
            }
            //later state
            else if translation.x <= -60 && translation.x >= -219 {
                rightIcons.alpha = 1
                leftIcons.alpha = 0
                UIView.animateWithDuration(0.2, animations: {
                    self.messageContainer.backgroundColor = self.laterColor
                    self.laterIcon.alpha = 1
                    self.ListIcon.alpha = 0
                })
            }
            //add to list state
            else if translation.x <= -220 {
                rightIcons.alpha = 1
                leftIcons.alpha = 0
                
                UIView.animateWithDuration(0.2, animations: {
                self.messageContainer.backgroundColor = self.listColor
                    self.laterIcon.alpha = 0
                    self.ListIcon.alpha = 1
                })
            }
            //grey / return to original state
            else if translation.x < 60 && translation.x > -60 {
                leftIcons.center = leftIconsOriginalCenter
                self.messageContainer.backgroundColor = self.greyColor
                UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: [], animations: ({
                }), completion: nil)
              
            }

        }
        else if sender.state == UIGestureRecognizerState.Ended {

            //archive or delete
            if translation.x < 60 && translation.x > -60 {
                UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: { () -> Void in
                    self.message.center = self.messageOriginalCenter

                    }, completion: nil)
            } else if translation.x >= 60 {
                UIView.animateWithDuration(0.1, animations: {
                self.message.center.x = self.messageOriginalCenter.x + 320
                    self.leftIcons.center.x += 320
                })
                
                UIView.animateWithDuration(0.4, delay: 0.2, options: [], animations: { () -> Void in
                    self.feedImage.center.y = self.feedImageOriginalCenter.y - 86
                    }, completion: nil)
                
                

            }
            
            //later state
            else if translation.x <= -60 && translation.x >= -219 {
                //show the choices, don't animate up
                modalButton.hidden = false
                UIView.animateWithDuration(0.1, animations: {
                    self.message.center.x = self.messageOriginalCenter.x - 320
                    self.rightIcons.center.x -= 320

                })

                UIView.animateWithDuration(0.6, delay: 0.2, options: [], animations: { () -> Void in
                    self.rescheduleModal.alpha = 1
                    }, completion: nil)

            }
            //add to list state
            else if translation.x <= -220 {
                //show choices, don't animate up
                modalButton.hidden = false
                UIView.animateWithDuration(0.1, animations: {
                    self.message.center.x = self.messageOriginalCenter.x - 320
                    self.rightIcons.center.x -= 320
                    
                })
                UIView.animateWithDuration(0.6, delay: 0.2, options: [], animations: { () -> Void in
                    self.listModal.alpha = 1
                    }, completion: nil)

            }
        }

    }
    
    
    @IBAction func onModalChoice(sender: AnyObject) {
        UIView.animateWithDuration(0.3) { () -> Void in
            
            self.listModal.alpha = 0
            self.rescheduleModal.alpha = 0
            self.modalButton.hidden = true
        }
        
        UIView.animateWithDuration(0.4, delay: 0.1, options: [], animations: { () -> Void in
            self.feedImage.center.y = self.feedImageOriginalCenter.y - 86
            }, completion: nil)
    }
    
    //switching between tabs

    @IBAction func onSegmentedControlTap(sender: AnyObject) {
        
        if segmentedControl.selectedSegmentIndex == 2 {
            
            //animate in archive
            
            let composeImage = UIImage(named: "composeGreen") as UIImage!
            self.composeIcon.setImage(composeImage, forState: .Normal)
            
            let menuImage = UIImage(named: "menuGreen") as UIImage!
            self.menuIcon.setImage(menuImage, forState: .Normal)

            archivedItems.center.x = archivedItemsOriginalCenter.x + 320
            
            UIView.animateWithDuration(0.4) { () -> Void in
               self.scrollView.center = CGPoint(x: self.scrollViewOriginalCenter.x - 320, y: self.scrollViewOriginalCenter.y)
                self.laterItems.center.x = self.laterItemsOriginalCenter.x - 320
                self.archivedItems.center.x = self.archivedItemsOriginalCenter.x
                self.segmentedControl?.tintColor = self.archiveColor
            }
            
        } else if segmentedControl.selectedSegmentIndex == 0 {
            laterItems.alpha = 1
            //animate in LATER items screen
            let composeImage = UIImage(named: "composeYellow") as UIImage!
            self.composeIcon.setImage(composeImage, forState: .Normal)
            
            let menuImage = UIImage(named: "menuYellow") as UIImage!
            self.menuIcon.setImage(menuImage, forState: .Normal)
            
            UIView.animateWithDuration(0.4) { () -> Void in
                self.laterItems.center.x = self.laterItemsOriginalCenter.x
                self.scrollView.center.x = self.scrollViewOriginalCenter.x + 320
                self.archivedItems.center.x = self.archivedItemsOriginalCenter.x + 320
                self.segmentedControl?.tintColor = self.laterColor
            }

        } else {

            //make sure it's the mailbox
            let composeImage = UIImage(named: "composeBlue") as UIImage!
            self.composeIcon.setImage(composeImage, forState: .Normal)
            
            let menuImage = UIImage(named: "menuBlue") as UIImage!
            self.menuIcon.setImage(menuImage, forState: .Normal)
            
            UIView.animateWithDuration(0.4) { () -> Void in
                self.scrollView.center.x = self.scrollViewOriginalCenter.x
                self.laterItems.center.x = self.laterItemsOriginalCenter.x - 320
                self.archivedItems.center.x = self.archivedItemsOriginalCenter.x + 320
                self.segmentedControl?.tintColor = self.mailboxColor
            }
            
        }
    }
    
    @IBAction func onSearchBoxTap(sender: AnyObject) {
      // searchTextField.becomeFirstResponder()
       animateSearchState()
        
    }
    @IBAction func onEditingDidBegin(sender: UITextField) {
        animateSearchState()
    }
    
    func animateSearchState() {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.searchView.center.y = self.searchViewOriginalCenter.y - 0
            self.searchView.center.x = self.searchViewOriginalCenter.x - 30
            self.helpMeText.alpha = 0
            self.navigationView.alpha = 0
            self.scrollView.center.y = self.scrollViewOriginalCenter.y - 80
            self.searchBox.transform = CGAffineTransformMakeScale(0.8, 1)
            self.searchDarken.alpha = 0.7
            self.searchTextField.center.x = self.searchTextFieldOriginalCenter.x - 80
            self.searchCancel.alpha = 1
            self.searchCancel.center = CGPoint(x: self.searchCancelOriginalCenter.x - 28, y: self.searchCancelOriginalCenter.y - 42)
        }
    }
    
    @IBAction func onSearchDarkenedTap(sender: AnyObject) {
        //close keyboard, take focus out of text box
        searchTextField.endEditing(true)
        searchTextField.text = ""
        UIView.animateWithDuration(0.4) { () -> Void in
            self.searchView.center.y = self.searchViewOriginalCenter.y
            self.searchView.center.x = self.searchViewOriginalCenter.x
            self.helpMeText.alpha = 1
            self.navigationView.alpha = 1
            self.scrollView.center.y = self.scrollViewOriginalCenter.y
            self.searchBox.transform = CGAffineTransformMakeScale(1, 1)
            self.searchDarken.alpha = 0
            self.searchTextField.center.x = self.searchTextFieldOriginalCenter.x
            self.searchCancel.alpha = 0
            self.searchCancel.center = CGPoint(x: self.searchCancelOriginalCenter.x, y: self.searchCancelOriginalCenter.y)

        }
    }
    
    
    @IBAction func onComposeTap(sender: AnyObject) {
        composeView.transform = CGAffineTransformMakeScale(1, 1)
        composeView.center = composeViewOriginalCenter
        UIView.animateWithDuration(0.6, delay: 0, options: [], animations: { () -> Void in
            self.composeView.center.y = self.composeViewOriginalCenter.y - 590
            self.composeDarken.alpha = 0.4
            }, completion: nil)
        delay(0.4) {
            toField.becomeFirstResponder()
        }
        
    }

    @IBAction func onEditingToField(sender: AnyObject) {
        if toField.text == "" {
            sendButton.enabled = false
        } else {
            sendButton.enabled = true
        }
    }
    @IBAction func onCancelPress(sender: AnyObject) {
        closeComposeNoAction()
    }
    
    @IBAction func onComposeDarkenTap(sender: AnyObject) {
        toField.endEditing(true)
        subjectField.endEditing(true)
        contentField.endEditing(true)
    }
    
    func closeComposeNoAction() {
        resetCompose()
        UIView.animateWithDuration(0.6, delay: 0, options: [], animations: { () -> Void in
            self.composeView.center.y = self.composeViewOriginalCenter.y
            delay(0.4) {
                self.composeDarken.alpha = 0
            }
            }, completion: nil)
    }
    
    
    func resetCompose() {
        sendButton.enabled = false
        toField.endEditing(true)
        subjectField.endEditing(true)
        contentField.endEditing(true)
        toField.text = ""
        subjectField.text = ""
        contentField.text = ""
    }
    
    @IBAction func onSendPress(sender: AnyObject) {
        resetCompose()
        UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
            self.composeView.transform = CGAffineTransformMakeScale(0.5, 0.5)
                self.composeView.center.y -= 300
            self.composeDarken.alpha = 0
            }, completion: nil)
    }
    
    func onEdgePan(edgeGesture: UIScreenEdgePanGestureRecognizer) {
        
        if segmentedControl.selectedSegmentIndex == 1 {
            laterItems.alpha = 0
        } else if segmentedControl.selectedSegmentIndex == 2 {
            scrollView.alpha = 0
            laterItems.alpha = 0

        } else if segmentedControl.selectedSegmentIndex == 0 {
            laterItems.alpha = 1
        }
        menuView.alpha = 1
        
        let layer = contentView.layer
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: -8, height: -3)
        layer.shadowOpacity = 0.2
        layer.shadowColor = UIColor.blackColor().CGColor
        
        let translation = edgeGesture.translationInView(view)
        let velocity = edgeGesture.velocityInView(view)
        
        
        if edgeGesture.state == UIGestureRecognizerState.Began {
            
        } else if edgeGesture.state == UIGestureRecognizerState.Changed {
            contentView.center.x = contentViewOriginalCenter.x + translation.x
        } else if edgeGesture.state == UIGestureRecognizerState.Ended {
            if velocity.x > 0 {
                contentView2.userInteractionEnabled = false
                let menuReturn = UIPanGestureRecognizer(target: self, action: "onMenuReturn:")
                contentView.addGestureRecognizer(menuReturn)
                UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                    self.contentView.center.x = self.contentViewOriginalCenter.x + 285
                    }, completion: nil)
            } else if velocity.x < 0 {
                UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                    self.contentView.center.x = self.contentViewOriginalCenter.x
                    }, completion: nil)
                contentView2.userInteractionEnabled = true
            }
        }
        
    }
    @IBAction func onMenuButtonPress(sender: AnyObject) {
        
        if segmentedControl.selectedSegmentIndex == 1 {
        laterItems.alpha = 0
        } else if segmentedControl.selectedSegmentIndex == 2 {
            scrollView.alpha = 0
            laterItems.alpha = 0

        } else if segmentedControl.selectedSegmentIndex == 0 {
            laterItems.alpha = 1
        }
        menuView.alpha = 1

        contentView2.userInteractionEnabled = false
        let menuReturn = UIPanGestureRecognizer(target: self, action: "onMenuReturn:")
        contentView.addGestureRecognizer(menuReturn)
        UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
            self.contentView.center.x = self.contentViewOriginalCenter.x + 285
            }, completion: nil)
        
    }
    
    func onMenuReturn(menuReturn: UIPanGestureRecognizer) {
        let translation = menuReturn.translationInView(view)
        let velocity = menuReturn.velocityInView(view)
        
        if menuReturn.state == UIGestureRecognizerState.Began {
            
        } else if menuReturn.state == UIGestureRecognizerState.Changed {
            contentView2.center.x = contentViewOriginalCenter.x + translation.x
        } else if menuReturn.state == UIGestureRecognizerState.Ended {
            if velocity.x > 0 {
                contentView2.userInteractionEnabled = false
                UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                    self.contentView2.center.x = self.contentViewOriginalCenter.x
                    }, completion: nil)
            } else if velocity.x < 0 {
                UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
                    self.contentView.center.x = self.contentViewOriginalCenter.x
                    self.contentView2.center.x = self.contentViewOriginalCenter.x
                    }, completion: nil)
                contentView.removeGestureRecognizer(menuReturn)
                contentView2.userInteractionEnabled = true
                delay(1) {
                    self.laterItems.alpha = 1
                    self.menuView.alpha = 0
                    self.scrollView.alpha = 1
                }
            }
        }
        
    }
    
    override func motionEnded(_ motion: UIEventSubtype,
        withEvent event: UIEvent?) {
            print("shaken")
              let undoAlertController = UIAlertController(title: "Undo action?", message: "Would you like to undo that?", preferredStyle: .Alert)
            let undoAction = UIAlertAction(title: "Undo", style: .Default) { (action) in
                // handle response here.
                
                self.leftIcons.center = self.leftIconsOriginalCenter
                self.rightIcons.center = self.rightIconsOriginalCenter
                
                UIView.animateWithDuration(0.4, delay: 0.2, options: [], animations: { () -> Void in
                    self.feedImage.center.y = self.feedImageOriginalCenter.y
                    }, completion: nil)
                
                UIView.animateWithDuration(0.1, animations: {
                    self.message.center.x = self.messageOriginalCenter.x - 1
                    self.leftIcons.center.x += 320
                })
            }
    
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                // handle response here.
            }
            undoAlertController.addAction(cancelAction)
            undoAlertController.addAction(undoAction)
            presentViewController(undoAlertController, animated: true, completion: nil)
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
