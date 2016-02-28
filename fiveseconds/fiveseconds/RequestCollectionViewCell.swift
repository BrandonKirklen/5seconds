//
//  RequestCollectionViewCell.swift
//  fiveseconds
//
//  Created by Vijay Sridhar on 2/27/16.
//  Copyright © 2016 behv. All rights reserved.
//

import UIKit

class RequestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func setUpCell(requestType: Request, name: (String, String), index: NSIndexPath) {
        imageView.image = UIImage(named: name.0)
        if (name.1.characters.count > 0) {
            setLabel("\(name.0)/\(name.1)")
        } else {
            setLabel("\(name.0)")
        }
    }
    
    func setLabel(text: String) {
        textLabel.text = text.lowercaseString
    }
}
