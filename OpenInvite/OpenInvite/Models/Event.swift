//
//  Event.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import Foundation

class Event {
    var hostID: String = ""
    var description: String = ""
    var attendingIDs: [String] = []
    var location: String = ""
    var time: Date = Date()
    var imageURL: String = ""
}
