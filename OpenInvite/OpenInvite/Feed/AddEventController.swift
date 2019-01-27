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
        self.present(stickerPickerVC, animated: true, completion: {
            
        })
    }
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    let stickerPickerVC = SCSDKBitmojiStickerPickerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stickerPickerVC.delegate = self
        
        addChild(stickerPickerVC)
        
        self.view.addSubview(stickerPickerVC.view)
        stickerPickerVC.didMove(toParent: self)
        
//        ConstraintHelper.set(on: loginButton, to: self.view, type: .leading, constant: 25)
//        ConstraintHelper.set(on: loginButton, to: self.view, type: .trailing, constant: -25)
//        ConstraintHelper.set(on: loginButton, to: self.view, type: .centerX, constant: 0)
//        ConstraintHelper.set(on: loginButton, to: self.view, type: .bottom, constant: -50)
//        ConstraintHelper.set(on: loginButton, to: nil, type: .height, constant: 70)
    }
    
    func bitmojiStickerPickerViewController(_ stickerPickerViewController: SCSDKBitmojiStickerPickerViewController, didSelectBitmojiWithURL bitmojiURL: String, image: UIImage?) {
        // do something
    }
    
    // Optional delegate method for listening to search field
    // focus changes
    func bitmojiStickerPickerViewController(_ stickerPickerViewController: SCSDKBitmojiStickerPickerViewController, searchFieldFocusDidChangeWithFocus hasFocus: Bool) {
        // do something
    }
}
