//
//  FeedController.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import UIKit
import SCSDKBitmojiKit
import Firebase

class FeedController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func profileAction(_ sender: Any) {
    }
    
    @IBOutlet weak var profileButton: UIButton!
    
    var events: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let eventsRef = db.collection("events")
        let listener = eventsRef.addSnapshotListener(updateEvents)
        
        let event = Event()
        event.hostID = "123"
        event.description = "Who wants to go to Whataburger?!?!"
        event.location = "11723 Glenway Dr Houston TX 77070"
        event.time = Date()
        
        events.append(event)
        events.append(event)
        events.append(event)
        events.append(event)
        
        setProfileImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setProfileImage() {
        let url = URL(string: user.imageURL)
        if let data = try? Data(contentsOf: url!) { profileButton.setImage(UIImage(data: data), for: UIControl.State.normal) }
    }
    
    func updateEvents(snapshot : QuerySnapshot?, error : Error?) {
        guard let documents = snapshot?.documents else {
            print("Error fetching documents: \(error!)")
            return
        }
        
        events.removeAll()
        for doc in documents {
            let data = doc.data()
            let event = Event(data)
            events.append(event)
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        cell.configure(event: events[indexPath.row])
        return cell
    }
}
