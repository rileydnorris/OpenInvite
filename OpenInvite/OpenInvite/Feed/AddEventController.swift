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
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addBitmojiAction(_ sender: Any) {
        ConstraintHelper.set(on: stickerPickerVC.view, to: self.view, type: .leading, constant: 10)
        ConstraintHelper.set(on: stickerPickerVC.view, to: self.view, type: .trailing, constant: -10)
        ConstraintHelper.set(on: stickerPickerVC.view, to: self.view, type: .bottom, constant: -50)
        ConstraintHelper.set(on: stickerPickerVC.view, to: self.view, type: .top, constant: 50)
    }
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var bitmojiImageView: UIImageView!
    
    let stickerPickerVC = SCSDKBitmojiStickerPickerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stickerPickerVC.delegate = self
        
        addChild(stickerPickerVC)
        
        self.view.addSubview(stickerPickerVC.view)
        stickerPickerVC.didMove(toParent: self)
    }
    
    func bitmojiStickerPickerViewController(_ stickerPickerViewController: SCSDKBitmojiStickerPickerViewController, didSelectBitmojiWithURL bitmojiURL: String, image: UIImage?) {
        stickerPickerVC.view.removeFromSuperview()
        bitmojiImageView.image = image
        print(bitmojiURL)
    }
    
    // Optional delegate method for listening to search field
    // focus changes
    func bitmojiStickerPickerViewController(_ stickerPickerViewController: SCSDKBitmojiStickerPickerViewController, searchFieldFocusDidChangeWithFocus hasFocus: Bool) {
        // do something
    }
}
