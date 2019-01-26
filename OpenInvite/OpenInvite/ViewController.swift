//
//  ViewController.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import UIKit
import SCSDKLoginKit

class ViewController: UIViewController {
    
    /// Action to login a user via Snapchat's API
    @IBAction func loginAction(_ sender: Any) {
        SCSDKLoginClient.login(from: self) { success, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print(success)
            }
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

