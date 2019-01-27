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
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var inviteTextLabel: UILabel!
    @IBOutlet weak var inviterNameLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    func configure(event: Event) {
        cardView.applySoftShadow()
        inviteTextLabel.text = event.description
        inviterNameLabel.text = "Jack Black"
        timeLabel.text = event.time.toString(dateFormat: "MM-dd h:mm a")
        locationLabel.text = event.location
    }
}
