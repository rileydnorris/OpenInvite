//
//  Extensions.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIView

extension UIView {
    
    /// Animates a view to scale in and display
    func animateScaleIn(on backgroundView: UIView) {
        backgroundView.addSubview(self)
        self.center = backgroundView.center
        self.isHidden = false
        
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        self.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.alpha = 1
            self.transform = CGAffineTransform.identity
        }
    }
    
    /// Animates a view to scale out remove from the display
    func animateScaleOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.alpha = 0
        }, completion: { (success: Bool) in
            self.removeFromSuperview()
        })
    }
    
    /// Animates a view bouncing
    func bounceAnimation() {
        self.transform = CGAffineTransform(scaleX: 0.93, y: 0.93)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    /// Makes a view round
    func makeRound() {
        self.clipsToBounds = true
        self.layer.cornerRadius =  0.5 * self.bounds.size.width
    }
    
    /// Applies a nice shadow to view, used for card layout
    func applySoftShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }
    
    /// Rounds the corners on a view
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path: UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask: CAShapeLayer = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        self.layer.masksToBounds = false
    }
    
    // MARK: Storyboard Options
    
    /// Makes a view round
    @IBInspectable var convertToRound: Bool {
        get {
            return self.convertToRound
        }
        set (hasDone) {
            if hasDone {
                makeRound()
            }
        }
    }
    
    /// Sets the corner radius on a view
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    /// Sets a border width on a view
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// Sets a border color on a view
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

// MARK: - UIDate

extension Date {
    
    /// Converts a date to a string based off a given format
    func toString(dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    /// Converts a date object into a string
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
    
    /// Returns the time off a date object
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: self)
    }
}

