//
//  ViewController.swift
//  fiveseconds
//
//  Created by Vijay Sridhar on 2/27/16.
//  Copyright © 2016 behv. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tabBarView: UIVisualEffectView!
        
    var groups: [Request] = [.Location, .Choice("",""), .Status(""), .Arrival(CLLocation()), .Visual];
    
    override func viewDidLoad() {
        collectionView.contentInset = UIEdgeInsetsMake(20, 0, 45, 0)
//        collectionView.number
//        tableView.registerNib(UINib.init(nibName: "GroupTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "groupCell")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int   {
        return 3
    }
    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        
//    }
//    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : RequestCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! RequestCollectionViewCell
        
        var text: String
        
        switch (groups[indexPath.row]) {
        case .Location:
            text = "Location"
            
        case .Choice("", ""):
            text = "Question"
            
        case .Arrival(CLLocation()):
            text = "ETA"
            
        case .Visual:
            text = "Photo"
            
        default:
            text = "Unknown"
            break
        }
        
        cell.imageView.image = UIImage(named: "camera")
        cell.textLabel.text = text
        
        return cell
    }

    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let aspect: CGFloat = UIScreen.mainScreen().bounds.size.width / 3.0
//        return CGSizeMake(shotWidth * aspect, shotHeight * aspect + 50)
//    }
//    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        switch (groups[indexPath.row]) {
        case .Location:
            break
            
        case .Arrival(CLLocation()):
            break
            
        case .Choice("", ""):
            
            break
            
        case .Visual:
            // Show camera
            break
            
        default:
            break
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

