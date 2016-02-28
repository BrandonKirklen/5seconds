//
//  CustomChoiceView.swift
//  
//
//  Created by Vijay Sridhar on 2/28/16.
//
//

import UIKit

class CustomChoiceView: UIView {
    var saveButtonHandler: ((String, String) -> Void)?
    
    @IBOutlet weak var choiceOneTextfield: UITextField!
    @IBOutlet weak var choiceTwoTextfield: UITextField!
    
    class func instantiateFromNib() -> CustomChoiceView {
        let view = UINib(nibName: "CustomChoiceView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! CustomChoiceView
        
        view.frame = CGRectMake(0, 0, 300, 200)
        view.layer.cornerRadius = 5
        return view
    }


    @IBAction func saveChoices(sender: AnyObject) {
        saveButtonHandler?(choiceOneTextfield.text!, choiceTwoTextfield.text!)
    }
}
