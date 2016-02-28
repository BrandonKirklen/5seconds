//
//  UINotificationActions.swift
//  fiveseconds
//
//  Created by Brandon Kirklen on 2016-2-59.
//  Copyright © 2016 behv. All rights reserved.
//

import Foundation
import UIKit

func UINotificationActionInit() {
    // increment Action
    let incrementAction = UIMutableUserNotificationAction()
    incrementAction.identifier = "INCREMENT_ACTION"
    incrementAction.title = "Add +1"
    incrementAction.activationMode = UIUserNotificationActivationMode.Background
    incrementAction.authenticationRequired = true
    incrementAction.destructive = false
    
    // decrement Action
    let decrementAction = UIMutableUserNotificationAction()
    decrementAction.identifier = "c"
    decrementAction.title = "Sub -1"
    decrementAction.activationMode = UIUserNotificationActivationMode.Background
    decrementAction.authenticationRequired = true
    decrementAction.destructive = false
    
    // reset Action
    let resetAction = UIMutableUserNotificationAction()
    resetAction.identifier = "RESET_ACTION"
    resetAction.title = "Reset"
    resetAction.activationMode = UIUserNotificationActivationMode.Foreground
    // NOT USED resetAction.authenticationRequired = true
    resetAction.destructive = true
    
    
    // Category
    let counterCategory = UIMutableUserNotificationCategory()
    counterCategory.identifier = "COUNTER_CATEGORY"
    
    // A. Set actions for the default context
    counterCategory.setActions([incrementAction, decrementAction, resetAction],
        forContext: UIUserNotificationActionContext.Default)
    
    // B. Set actions for the minimal context
    counterCategory.setActions([incrementAction, decrementAction],
        forContext: UIUserNotificationActionContext.Minimal)
    
    let settings = UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: NSSet(object: counterCategory) as? Set<UIUserNotificationCategory>)
    UIApplication.sharedApplication().registerUserNotificationSettings(settings)

}