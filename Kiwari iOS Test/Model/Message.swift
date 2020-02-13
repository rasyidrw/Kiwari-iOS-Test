//
//  Message.swift
//  Kiwari iOS Test
//
//  Created by Rasyid Respati Wiriaatmaja on 13/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import UIKit

class Message: NSObject {

    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var toId: String?
    
    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.toId = dictionary["toId"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
    }
    
}
