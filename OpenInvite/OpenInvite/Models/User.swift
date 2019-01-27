//
//  User.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import Foundation

class User {
    var id: String = ""
    var displayName: String = ""
    var friendIDs: [String] = []
    var imageURL: String = ""
    
    init(){}
    
    init(_ data : [String : Any]) {
        print(data)
        id = data["id"] as? String ?? "N/A"
        displayName = data["displayName"] as? String ?? "N/A"
        friendIDs = data["friendIDs"] as? [String] ?? []
        imageURL = data["imageURL"] as? String ?? "N/A"
        
    }
    
}
