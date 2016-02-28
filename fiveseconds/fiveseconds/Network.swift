//
//  Network.swift
//  fiveseconds
//
//  Created by Brandon Kirklen on 2016-2-59.
//  Copyright © 2016 behv. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


func uploadImage(image: UIImage, success: Bool -> ()) {
    let imageData = UIImagePNGRepresentation(image)
    let base64String = imageData!.base64EncodedStringWithOptions([])
    
    let parameters = [
        "image": base64String,
        "type": "url",
        "title": "5seconds"
    ]
    
    let headers = [
        "clientID": "a2937890588dc17",
        "clientSecret": "252fd9cf8d972f3b3fbb05030a2a9da916b2441b"
    ]
    
    Alamofire.request(.POST, "https://api.imgur.com/3/image", parameters: parameters, headers: headers)
    .response { request, response, data, error in
            print(request)
            print(response)
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            print(error)
            success(true)
    }
}

func uploadFile(fileUrl: NSURL) {
    let boundary: String = "---------------------\(arc4random())\(arc4random())"
    var apiKeys: Dictionary<String, String>?
    let clientID = apiKeys!["ClientID"]!
    //        let clientSecret = apiKeys!["ClientSecret"]!
    let imageData: NSData = try! NSData(contentsOfURL: fileUrl, options: [])
    
    let url: String = "https://api.imgur.com/3/image"
    let request: NSMutableURLRequest = NSMutableURLRequest()
    request.URL = NSURL(string: url)
    request.HTTPMethod = "POST"
    
    let requestBody = NSMutableData()
    let contentType = "multipart/form-data; boundary=\(boundary)"
    request.addValue(contentType, forHTTPHeaderField: "Content-Type")
    request.addValue("Client-ID \(clientID)", forHTTPHeaderField: "Authorization")
    
    requestBody.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    requestBody.appendData("Content-Disposition: attachment; name=\"image\"; filename=\".\(fileUrl)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    
    requestBody.appendData("Content-Type: application/octet-stream\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    requestBody.appendData(imageData)
    requestBody.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    requestBody.appendData("--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    
    request.HTTPBody = requestBody
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
        if error != nil || data == nil {
            NSLog(error!.localizedDescription);
        } else {
            if let responseDict: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(data!, options: [])) as? NSDictionary {
                print("Received response: \(responseDict)")
                if responseDict.valueForKey("status") != nil && responseDict.valueForKey("status")?.integerValue == 200 {
                    let imgLink = responseDict.valueForKey("data")!.valueForKey("link") as! String
                    print("Image Uploaded:", terminator: "")
                    print(imgLink);
                    
                } else {
                    NSLog("An error occurred: %@", responseDict);
                }
            } else {
                NSLog("An error occurred - the response was invalid: %@", response!)
            }
        }
    })
    
    
}
