//
//  ViewController.swift
//  fiveseconds
//
//  Created by Vijay Sridhar on 2/27/16.
//  Copyright © 2016 behv. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBarView: UIVisualEffectView!
        
    var groups: [Request] = [.Location, .Choice("",""), .Status(""), .Visual];
    
    var locations = ["Location", "ETA"]
    var choices = [("Custom", ""), ("Pizza", "Burgers"), ("Eat out", "in")]
    var statuses = ["Ready", "Late", "Safe", "There", "Hungry", "Busy", "Awake"]
    var visuals = ["Photo", "Video"]

    override func viewDidLoad() {
        collectionView.contentInset = UIEdgeInsetsMake(-20, 0, 60, 0)
        super.viewDidLoad()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch (groups[section]) {
        case .Location:
            return locations.count
        
        case .Choice("", ""):
            return choices.count
            
        case .Status(""):
            return statuses.count
            
        case .Visual:
            return visuals.count

        default:
            return 0
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int   {
        return groups.count
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var headerView: HeaderCollectionReusableView = HeaderCollectionReusableView()
        
        if (kind == UICollectionElementKindSectionHeader) {
            headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "header", forIndexPath: indexPath) as! HeaderCollectionReusableView
            
            switch (groups[indexPath.section]) {
            case .Location:
                headerView.headerLabel.text = "Location"
                
            case .Choice("", ""):
                headerView.headerLabel.text = "Choices"
                
            case .Status(""):
                headerView.headerLabel.text = "Status"
                
            case .Visual:
                headerView.headerLabel.text = "Snapshots"
                
            default:
                headerView.headerLabel.text = ""
            }
        }
        
        return headerView
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : RequestCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! RequestCollectionViewCell
        
        switch (groups[indexPath.section]) {
        case .Location:
            cell.setUpCell(.Location, name: (locations[indexPath.row], ""), index: indexPath)
            
        case .Choice("", ""):
            cell.setUpCell(.Choice("", ""), name: choices[indexPath.row], index: indexPath)
            
        case .Status(""):
            cell.setUpCell(.Status(""), name: (statuses[indexPath.row], ""), index: indexPath)
            
        case .Visual:
            cell.setUpCell(.Visual, name: (visuals[indexPath.row], ""), index: indexPath)
            
        default:
            cell.setUpCell(.Location, name: (locations[indexPath.row], ""), index: indexPath)
        }
        
        return cell
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let contactView : ContactTableViewController! = storyboard?.instantiateViewControllerWithIdentifier("ContactTableView") as! ContactTableViewController
        
        switch (groups[indexPath.section]) {
        case .Location:
            break
            
        case .Choice("", ""):
//            SVProgressHUD.show
//            SVProgressHUD.sho
            break
            
        case .Status(""):
            break
            
        case .Visual:
            // Show camera
            break
            
        default:
            break
        }
        
        let status = CNContactStore.authorizationStatusForEntityType(.Contacts)
        if status == .Denied || status == .Restricted {
            // user previously denied, so tell them to fix that in settings
            return
        }
        
        // open it
        
        let store = CNContactStore()
        store.requestAccessForEntityType(.Contacts) { granted, error in
            guard granted else {
                dispatch_async(dispatch_get_main_queue()) {
                    // user didn't grant authorization, so tell them to fix that in settings
                    print(error)
                }
                return
            }
            
            let request = CNContactFetchRequest(keysToFetch: [CNContactIdentifierKey, CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactPhoneNumbersKey])
            do {
                try store.enumerateContactsWithFetchRequest(request) { contact, stop in
                    contactView.contacts.append(contact)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    let view = CustomChoiceView.instantiateFromNib()
                    let window = UIApplication.sharedApplication().delegate?.window!
                    let modal = PathDynamicModal()
                    modal.showMagnitude = 100.0
                    modal.closeMagnitude = 130.0
                    view.saveButtonHandler = { choice1, choice2 in
                        print(choice1)
                        print(choice2)
                        modal.closeWithLeansRandom()
                    }
                    
                    modal.show(modalView: view, inView: window!)
                })
//                self.presentViewController(contactView, animated: true, completion: { () -> Void in
                
//                })
            } catch {
                print(error)
            }
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

