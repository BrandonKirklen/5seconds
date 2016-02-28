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
    // yes Action
    let yesAction = UIMutableUserNotificationAction()
    yesAction.identifier = "YES_ACTION"
    yesAction.title = "Yes"
    yesAction.activationMode = UIUserNotificationActivationMode.Background
    yesAction.authenticationRequired = true
    yesAction.destructive = false
    
    // no Action
    let noAction = UIMutableUserNotificationAction()
    noAction.identifier = "NO_ACTION"
    noAction.title = "No"
    noAction.activationMode = UIUserNotificationActivationMode.Background
    noAction.authenticationRequired = true
    noAction.destructive = false
    
    // Category
    let questionCategory = UIMutableUserNotificationCategory()
    questionCategory.identifier = "QUESTION_CATEGORY"

    questionCategory.setActions([yesAction, noAction],
        forContext: UIUserNotificationActionContext.Minimal)
    
    let settings = UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: [questionCategory])
    UIApplication.sharedApplication().registerUserNotificationSettings(settings)

}