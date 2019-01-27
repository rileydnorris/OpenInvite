//
//  Extensions.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import Foundation
import UIKit
import MapKit

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

// MARK: - UILabel

extension UILabel {
    var defaultFont: UIFont? {
        get { return self.font }
        set { self.font = UIFont(name: "Avenir-Next", size: 14) }
    }
}

// MARK: - UITextField

extension UITextField {
    
    /// Adds done button to the keyboard
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        done.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 17)!], for: UIControl.State.normal)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        var items: [UIBarButtonItem] = []
        
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        doneToolbar.barTintColor = UIColor.white
        doneToolbar.tintColor = UIColor.purple
        self.inputAccessoryView = doneToolbar
    }
    
    /// Obj-C function to use in the `addDoneButtonOnKeyboard` function
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
    
    /// Creates a storyboard option for the done button
    @IBInspectable var doneAccessory: Bool {
        get {
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone {
                addDoneButtonOnKeyboard()
            }
        }
    }
}

// MARK: - UIImage

extension UIImageView {
    
    /// Loads an image from a URL into a UIImage
    func loadFromURL(urlString: String) {
        let url = URL(string: urlString)
        if let data = try? Data(contentsOf: url!) { self.image = UIImage(data: data) }
    }
}

// MARK: - AnnotationView

extension MKAnnotationView {
    
    /// Loads an image from a URL into a UIImage
    func loadFromURL(urlString: String) {
        let url = URL(string: urlString)
        if let data = try? Data(contentsOf: url!) { self.image = UIImage(data: data) }
    }
}

// MARK: - UIViewController

extension UIViewController {
    
    /// Displays an alert and screen shake on the current view controller
    func handle(error: String) {
        DispatchQueue.main.async {
            // vibrate and shake screen
            if let view: UIView = self.viewIfLoaded {
                view.transform = CGAffineTransform(translationX: 30, y: 0)
                UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    view.transform = CGAffineTransform.identity
                }, completion: nil)
            }
            let alertController: UIAlertController = UIAlertController(title: "Whoops!", message: error, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            }))
            self.present(alertController, animated: true, completion: nil)
            notificationFeedback.notificationOccurred(.error)
        }
    }
}

