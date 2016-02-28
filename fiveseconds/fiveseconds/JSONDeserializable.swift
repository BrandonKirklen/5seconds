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
        switch self {
        case .Location:
            result["type"].string = "Location"
        case let .Choice(choiceSide):
            result["type"].string = "Choice"
            switch choiceSide {
            case .Left:
                result["ChoiceSide"].string = "left"
            case .Right:
                result["ChoiceSide"].string = "right"
            }
        case let .Arrival(timeOfArrival):
            result["type"].string = "Arrival"
            result["arrival"].double = timeOfArrival.timeIntervalSince1970
        case let .Status(status):
            result["type"].string = "Status"
            result["status"].bool = status
        case let .Visual(awsURL):
            result["type"].string = "Visual"
            result["AWS URL"].string = awsURL
        }
        return result
    }
}