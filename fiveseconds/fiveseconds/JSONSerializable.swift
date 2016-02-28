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
        result["contents"] = [:]
        switch self {
        case .Location:
            result["tag"].string = "LocationRequest"
        case let .Choice(left, right):
            result["tag"].string = "ChoiceRequest"
            result["contents"]["left"].string = left
            result["contents"]["right"].string = right
        case let .Arrival(location):
            result["tag"].string = "ArrivalRequest"
            result["contents"]["latitude"].double = location.coordinate.latitude
            result["contents"]["longitude"].double = location.coordinate.longitude
        case let .Status(status):
            result["tag"].string = "StatusRequest"
            result["contents"]["status"].string = status
        case .Visual:
            result["tag"].string = "VisualRequest"
        }
        return result
    }
}

