//
//  Constraints.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import Foundation
import UIKit

class ConstraintHelper {
    
    static func set(on onItem: UIView, to toItem: UIView?, type: NSLayoutConstraint.Attribute, constant: CGFloat) {
        
        onItem.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: onItem, attribute: type, relatedBy: NSLayoutConstraint.Relation.equal, toItem: toItem, attribute: type, multiplier: 1, constant: constant).isActive = true
    }
}
