//
//  DataModels.swift
//  fiveseconds
//
//  Created by Brandon Kirklen on 2016-2-58.
//  Copyright © 2016 behv. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

enum Request {
    case Location
    case Choice(String, String)
    case Arrival(CLLocation)
    case Status(String)
    case Visual
}

enum Response {
    case Location(CLLocation)
    case Choice(ChoiceSide)
    case Arrival(NSDate)
    case Status(Bool)
    case Visual(String)
}

enum ChoiceSide {
    case Left
    case Right
}

struct Interaction {
    var personID: Int
    var request: Request
    var response: Response
}