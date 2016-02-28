//
//  JSONSerializer.swift
//  fiveseconds
//
//  Created by Brandon Kirklen on 2016-2-58.
//  Copyright © 2016 behv. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONSerializable {
    func serialize() -> JSON
}

extension Request: JSONSerializable {
    func serialize() -> JSON {
        var result: JSON = [:]
        switch self {
        case .Location:
            result["type"].string = "Location"
        case let .Choice(left, right):
            result["type"].string = "Choice"
            result["left"].string = left
            result["right"].string = right
        case let .Arrival(location):
            result["type"].string = "Arrival"
            result["latitude"].double = location.coordinate.latitude
            result["longitude"].double = location.coordinate.longitude
        case let .Status(status):
            result["type"].string = "Status"
            result["status"].string = status
        case .Visual:
            result["type"].string = "Visual"
        }
        return result
    }
}

