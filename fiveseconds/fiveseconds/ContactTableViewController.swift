//
//  ContactTableViewController.swift
//  fiveseconds
//
//  Created by Vijay Sridhar on 2/28/16.
//  Copyright © 2016 behv. All rights reserved.
//

import UIKit
import Contacts

class ContactTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    
    var lastSelectedIndexPath = NSIndexPath(forRow: -1, inSection: 0)
    var contacts = [CNContact]()

    override func viewDidLoad() {
        
        tableView.allowsMultipleSelection = true;

//        let status = CNContactStore.authorizationStatusForEntityType(.Contacts)
//        if status == .Denied || status == .Restricted {
//            // user previously denied, so tell them to fix that in settings
//            return
//        }
//        
//        // open it
//        
//        let store = CNContactStore()
//        store.requestAccessForEntityType(.Contacts) { granted, error in
//            guard granted else {
//                dispatch_async(dispatch_get_main_queue()) {
//                    // user didn't grant authorization, so tell them to fix that in settings
//                    print(error)
//                }
//                return
//            }
//            
//            // get the contacts
//            
//            let request = CNContactFetchRequest(keysToFetch: [CNContactIdentifierKey, CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactPhoneNumbersKey])
//            do {
//                try store.enumerateContactsWithFetchRequest(request) { contact, stop in
//                    self.contacts.append(contact)
//                }
//                print(self.contacts.count)
//                self.tableView.reloadData()
//            } catch {
//                print(error)
//            }
//            
//            // do something with the contacts array (e.g. print the names)
//            
//            let formatter = CNContactFormatter()
//            formatter.style = .FullName
////            for contact in self.contacts {
////                print(formatter.stringFromContact(contact))
////            }
//        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func dismissView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    @IBAction func sendToContacts(sender: AnyObject) {
        var phoneNumberArray = [String]()

        for (_, indexPath) in self.tableView.indexPathsForSelectedRows!.enumerate() {
            if (contacts[indexPath.row].phoneNumbers.count > 0) {
                var phoneNumber = (contacts[indexPath.row].phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as! String
                
                if (phoneNumber.characters.count == 12) {
                    phoneNumber.removeAtIndex(phoneNumber.startIndex)
                    phoneNumber.removeAtIndex(phoneNumber.startIndex)
                }
                print(phoneNumber)
                phoneNumberArray.append(phoneNumber)
            }
        }
        
        print(phoneNumberArray)
        
        if (phoneNumberArray.count > 0) {
            dismissView(self)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        print(self.contacts.count)
        // Configure the cell...
        cell.textLabel!.text = "\(contacts[indexPath.row].givenName) \(contacts[indexPath.row].familyName)"
        if (contacts[indexPath.row].phoneNumbers.count > 0) {
            var phoneNumber = (contacts[indexPath.row].phoneNumbers[0].value as! CNPhoneNumber).valueForKey("digits") as! String
            if (phoneNumber.characters.count == 12) {
                phoneNumber.removeAtIndex(phoneNumber.startIndex)
                phoneNumber.removeAtIndex(phoneNumber.startIndex)
            }
            
            if (!phoneNumber.containsString("-") && phoneNumber.characters.count == 10) {
                phoneNumber.insert("-", atIndex: phoneNumber.startIndex.advancedBy(3))
                phoneNumber.insert("-", atIndex: phoneNumber.startIndex.advancedBy(7))
            }
            cell.detailTextLabel!.text = "\(phoneNumber)"
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.None

        if cell.selected
        {
            cell.selected = false
            if cell.accessoryType == UITableViewCellAccessoryType.None
            {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if cell!.selected
        {
            cell!.selected = false
            if cell!.accessoryType == UITableViewCellAccessoryType.None
            {
                cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else
            {
                cell!.accessoryType = UITableViewCellAccessoryType.None
            }
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return contacts.count
    }
}
