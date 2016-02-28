//
//  JSONDeserializable.swift
//  fiveseconds
//
//  Created by Brandon Kirklen on 2016-2-58.
//  Copyright © 2016 behv. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONDeserializable {
    func deserialize() -> JSON
}

extension Response: JSONDeserializable {
    func deserialize() -> JSON {
        var result: JSON = [:]
        result["contents"] = [:]
        switch self {
        case .Location:
            result["tag"].string = "Location"
        case let .Choice(choiceSide):
            result["tag"].string = "Choice"
            switch choiceSide {
            case .Left:
                result["contents"]["Choice"].string = "Left"
            case .Right:
                result["contents"]["Choice"].string = "Right"
            }
        case let .Arrival(timeOfArrival):
            result["tag"].string = "Arrival"
            result["contents"]["arrival"].double = timeOfArrival.timeIntervalSince1970
        case let .Status(status):
            result["tag"].string = "Status"
            result["contents"]["status"].bool = status
        case let .Visual(awsURL):
            result["tag"].string = "Visual"
            result["contents"]["AWS URL"].string = awsURL
        }
        return result
    }
}