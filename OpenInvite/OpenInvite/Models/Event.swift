//
//  Event.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import Foundation
import Firebase

class Event {
    
    var id: String = ""
    var hostID: String = ""
    var description: String = ""
    var attendingIDs: [String] = []
    var location: String = ""
    var time: Date = Date()
    var imageURL: String = ""
    
    init(_ data : [String : Any]) {
        print(data)
        hostID = data["hostID"] as! String
        description = data["description"] as! String
        location = data["location"] as! String
        var fireTime = data["time"] as! Timestamp
        time = Date(timeIntervalSince1970: TimeInterval(fireTime.seconds))
        imageURL = data["imageURL"] as! String
    }
    
    init() {
    }
    
    /// Saves the object in firebase
    func save() {
        let convertedObject: [String : Any] = [
            "id" : id,
            "hostID" : hostID,
            "description" : description,
            "attendingIDs" : attendingIDs,
            "location" : location,
            "time" : time,
            "imageURL" : imageURL,
        ]
        
        setDocument("events", id, convertedObject)
    }
}
