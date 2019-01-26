//
//  FeedController.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import UIKit

class FeedController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var events: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let event = Event()
        event.hostID = "123"
        event.description = "Who wants to go to Whataburger?!?!"
        event.location = "11723 Glenway Dr Houston TX 77070"
        event.time = Date()
        
        events.append(event)
        events.append(event)
        events.append(event)
        events.append(event)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        cell.configure(description: events[indexPath.row].description, hostName: "Jack Black")
        return cell
    }
}
