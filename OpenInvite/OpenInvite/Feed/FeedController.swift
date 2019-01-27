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
    
    var cardInfo: [(User, Event)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let eventsRef = db.collection("events")
        let _ = eventsRef.addSnapshotListener(updateEvents)
        
        setProfileImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setProfileImage() {
        let url = URL(string: user.imageURL)
        print(user.imageURL)
        if let data = try? Data(contentsOf: url!) { profileButton.setImage(UIImage(data: data), for: UIControl.State.normal) }
    }
    
    func updateEvents(snapshot : QuerySnapshot?, error : Error?) {
        guard let documents = snapshot?.documents else {
            print("Error fetching documents: \(error!)")
            return
        }
        
        cardInfo.removeAll()
        for doc in documents {
            let data = doc.data()
            let event = Event(data)
            getDocumentByID("users", data["hostID"] as! String) { (document, error) in
                let userData = document?.data()
                let user = User(userData ?? [:])
                self.cardInfo.append((user, event))
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        cell.configure(event: cardInfo[indexPath.row].1, user: cardInfo[indexPath.row].0)
        return cell
    }
}
