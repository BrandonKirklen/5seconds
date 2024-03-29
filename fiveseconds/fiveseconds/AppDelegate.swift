//
//  AppDelegate.swift
//  fiveseconds
//
//  Created by Vijay Sridhar on 2/27/16.
//  Copyright © 2016 behv. All rights reserved.
//

import UIKit
import OneSignalKit
import MapKit
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let oneSignal = OneSignal(launchOptions: launchOptions, appId: "f3afdc44-708c-480d-916a-be561ef7871b", handleNotification: nil)
        
        OneSignal.defaultClient()?.enableInAppAlertNotification(true)
        
        //        uploadFile(NSBundle.mainBundle().URLForResource("testpic", withExtension: "png")!)
        return true
    }
    
    func getETA() -> String {
        
        let url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=34.164524,-118.175790&destinations=34.147785,-118.144516&key=AIzaSyATFt2ywx3EuGDy3nzMio3h2q5c627WNiY"
        
        var val = "-"
        Alamofire.request(.GET, url, parameters: nil, encoding: .JSON, headers: nil).responseJSON { response in
            switch response.result {
            case .Success(let JSON):
                
                let response = JSON as! NSDictionary
                let distance = response.objectForKey("rows")![0].objectForKey("elements")![0].objectForKey("duration")!.objectForKey("text")!
                print(distance)
                val = distance as! String
                
            case .Failure(let error):
                print("Error: \(error)")
            }
        }
        
        return val
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        let type = userInfo["custom"]!["a"]!!["type"]! as! String
        let requester = userInfo["custom"]!["a"]!!["requester"]! as! String

        let localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "answer"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 1)
        
        let axnA = UIMutableUserNotificationAction()
        axnA.identifier = "A"
        axnA.activationMode = UIUserNotificationActivationMode.Background
        axnA.authenticationRequired = false
        axnA.destructive = false
  
        let axnB = UIMutableUserNotificationAction()
        axnB.identifier = "B"
        axnB.activationMode = UIUserNotificationActivationMode.Background
        axnB.authenticationRequired = false
        axnB.destructive = false

        axnA.title = ""
        axnB.title = ""
        
        var alert = "\(requester) "
        switch type {
            case "ETA":
                alert += "wants to know your ETA."
                axnA.title = "Send \(getETA()) ETA."
            case "AB":
                let A = userInfo["custom"]!["a"]!!["A"]! as! String
                let B = userInfo["custom"]!["a"]!!["B"]! as! String
                alert += "wants to know: \(A) or \(B)?"
                axnA.title = A
                axnB.title = B
            case "OK":
                alert += "says TBD"
                axnA.title = "Confirm"
            case "YN":
                let message = userInfo["custom"]!["a"]!!["message"]! as! String
                alert += "wants to know: \(message)?"
                axnA.title = "Yes"
                axnB.title = "No"
            case "IO":
                alert += "wants to know if you want to eat in or out."
                axnA.title = "In"
                axnB.title = "Out"
            case "PB":
                alert += "wants to know if you want burgers or pizza."
                axnA.title = "Burgers"
                axnB.title = "Pizza"
            case "L":
                alert += "wants to know your current location."
                axnA.title = "Send location"
            default:
                print("something else")
        }
        
        localNotification.alertBody = alert

        var arr = [axnA, axnB]
        if axnB.title == "" {
            arr = [axnA]
        }
    
        
        let category = UIMutableUserNotificationCategory()
        category.identifier = "TESTCATEGORY"
        
        category.setActions(arr,
            forContext: UIUserNotificationActionContext.Default)
        
        category.setActions(arr,
            forContext: UIUserNotificationActionContext.Minimal)
        
        localNotification.category = "TESTCATEGORY"
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert, categories: NSSet(object: category) as? Set<UIUserNotificationCategory>))
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
    
        
        
        //
        //        let req = MKDirectionsRequest()
        //
        //        req.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2DMake(34.164524, -118.175790), addressDictionary: nil))
        //
        //        req.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2DMake(34.147785, -118.144516), addressDictionary: nil))
        //
        //        req.transportType = MKDirectionsTransportType.Automobile
        //        req.requestsAlternateRoutes = false
        //
        //        print(req)
        //
        //        let dir = MKDirections(request: req)
        //
        //
        //        dir.calculateDirectionsWithCompletionHandler { (x :MKDirectionsResponse?, y : NSError?) -> Void in
        //            print("something")
        //            if let z = x {
        //                if z.routes.count > 0 {
        //                    let route = z.routes[0]
        //                    print(route.expectedTravelTime)
        //
        //
        //
        //                }
        //                else {
        //                    print("0 things")
        //                }
        //            }
        //            else {
        //                print("error")
        //            }
        //        }
        
        
        
        completionHandler(UIBackgroundFetchResult.NewData)
    }
    
    //    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    //        print("hey")
    //    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

