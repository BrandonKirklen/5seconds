//
//  fivesecondsTests.swift
//  fivesecondsTests
//
//  Created by Brandon Kirklen on 2016-2-59.
//  Copyright © 2016 behv. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import fiveseconds

class fivesecondsTests: XCTestCase {
    
    func testSerialization() {
        let x = Request.Choice("Cookies", "Milk")
        print(x.serialize())
    }
    
}
