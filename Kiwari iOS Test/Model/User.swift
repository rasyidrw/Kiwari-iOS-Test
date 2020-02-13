//
//  User.swift
//  Kiwari iOS Test
//
//  Created by Rasyid Respati Wiriaatmaja on 13/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: String?
    var username: String?
    var email: String?
    var profileImageUrl : String?
    
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String
        self.username = dictionary["username"] as? String
        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}
