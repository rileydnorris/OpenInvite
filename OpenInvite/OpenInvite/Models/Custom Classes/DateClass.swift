//
//  DateClass.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/27/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import UIKit

class DateClass: UITextField {
    
    var date: Date = Date()
    let datePicker: UIDatePicker = UIDatePicker()
    
    override func awakeFromNib() {
        createDatePicker()
    }
    
    /// Fuction to set the text and date from a view controller
    func setText(from newDate: Date) {
        self.text = newDate.toString()
        self.date = newDate
    }
    
    /// Sets up the date picker within the textfield
    func createDatePicker() {
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.addTarget(self, action: #selector(selectDate), for: UIControl.Event.valueChanged)
        self.inputView = datePicker
        self.inputView!.backgroundColor = UIColor.white
    }
    
    /// Function called when selcting a date
    @objc func selectDate() {
        date = datePicker.date
        self.text = date.toString()
    }
}
