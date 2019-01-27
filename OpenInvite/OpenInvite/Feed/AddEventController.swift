//
//  AddEventController.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import UIKit
import SCSDKBitmojiKit

class AddEventController: UIViewController, SCSDKBitmojiStickerPickerViewControllerDelegate {
    
    @IBAction func addEventAction(_ sender: Any) {
        event.id = UUID().uuidString
        event.id = event.id.replacingOccurrences(of: "/", with: "|")
        event.description = descriptionTextField.text!
        event.time = eventTime
        event.location = locationTextField.text!
        event.hostID = user.id
        event.save()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addBitmojiAction(_ sender: Any) {
        ConstraintHelper.set(on: stickerPickerVC.view, to: self.view, type: .leading, constant: 10)
        ConstraintHelper.set(on: stickerPickerVC.view, to: self.view, type: .trailing, constant: -10)
        ConstraintHelper.set(on: stickerPickerVC.view, to: self.view, type: .bottom, constant: -50)
        ConstraintHelper.set(on: stickerPickerVC.view, to: self.view, type: .top, constant: 50)
    }
    
    let event = Event()
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var bitmojiImageView: UIImageView!
    
    var eventTime: Date = Date()
    let datePicker: UIDatePicker = UIDatePicker()
    
    let stickerPickerVC = SCSDKBitmojiStickerPickerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar.isHidden = true
        
        stickerPickerVC.delegate = self
        
        addChild(stickerPickerVC)
        
        self.view.addSubview(stickerPickerVC.view)
        stickerPickerVC.didMove(toParent: self)
        
        createDatePicker()
    }
    
    func bitmojiStickerPickerViewController(_ stickerPickerViewController: SCSDKBitmojiStickerPickerViewController, didSelectBitmojiWithURL bitmojiURL: String, image: UIImage?) {
        stickerPickerVC.view.removeFromSuperview()
        event.imageURL = bitmojiURL
        bitmojiImageView.image = image
    }
    
    // Optional delegate method for listening to search field
    // focus changes
    func bitmojiStickerPickerViewController(_ stickerPickerViewController: SCSDKBitmojiStickerPickerViewController, searchFieldFocusDidChangeWithFocus hasFocus: Bool) {
        // do something
    }
    
    /// Sets up the date picker within the textfield
    func createDatePicker() {
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.addTarget(self, action: #selector(selectDate), for: UIControl.Event.valueChanged)
        timeTextField.inputView = datePicker
        timeTextField.inputView!.backgroundColor = UIColor.white
    }
    
    /// Function called when selcting a date
    @objc func selectDate() {
        eventTime = datePicker.date
        timeTextField.text = eventTime.toString(dateFormat: "MM-dd hh:mm a")
    }
}
