//
//  FeedCell.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBAction func acceptAction(_ sender: Any) {
    }
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var inviteTextLabel: UILabel!
    @IBOutlet weak var inviterNameLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    func configure(event: Event, user: User) {
        cardView.applySoftShadow()
        inviteTextLabel.text = event.description
        inviterNameLabel.text = user.displayName
        timeLabel.text = event.time.toString(dateFormat: "MM-dd h:mm a")
        locationLabel.text = event.location
        
        setProfileImage(user)
        setEventImage(event)
        
    }
    
    
    func setProfileImage(_ user: User) {
        DispatchQueue.main.async {
            var imageURL = ""
            if (user.imageURL.isEmpty) {
                imageURL = "https://i.kym-cdn.com/entries/icons/original/000/016/212/manning.png"
            } else {
                imageURL = user.imageURL
            }
            
            let url = URL(string: imageURL)
            if let data = try? Data(contentsOf: url!) {
                self.userAvatar.image = UIImage(data: data)
            }
        }
    }
    
    func setEventImage(_ event: Event) {
        DispatchQueue.main.async {
            var imageURL = ""
            if (event.imageURL.isEmpty) {
                imageURL = "https://i.kym-cdn.com/entries/icons/original/000/016/212/manning.png"
            } else {
                imageURL = event.imageURL
            }
            
            let url = URL(string: imageURL)
            
            if let data = try? Data(contentsOf: url!) { self.eventImage.image = UIImage(data: data) }
        }
    }
}

