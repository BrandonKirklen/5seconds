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
    
    func setUpCell(requestType: Request, name: String, index: NSIndexPath) {
        imageView.image = UIImage(named: name)
        setLabel(name)
    }
    
    func setLabel(text: String) {
        textLabel.text = text.lowercaseString
    }
}
