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
    
    /// Saves the object in firebase
    func save() {
        let convertedObject: [String : Any] = [
            "id" : id,
            "displayName" : displayName,
            "friendIDs" : friendIDs,
            "imageURL" : imageURL
        ]
        
        setDocument("users", id, convertedObject)
    }
}
