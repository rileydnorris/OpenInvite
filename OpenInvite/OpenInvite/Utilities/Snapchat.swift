//
//  Snapchat.swift
//  OpenInvite
//
//  Created by Riley Norris on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import Foundation
import SCSDKLoginKit

class Snapchat {
    
    static func logIn(controller: UIViewController) {
        SCSDKLoginClient.login(from: controller) { success, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                Snapchat.retrieveData()
            }
        }
    }
    
    static func retrieveData() {
        let graphQLQuery = "{me{displayName, bitmoji{avatar}, externalId}}"
        let variables = ["page": "bitmoji"]
        
        SCSDKLoginClient.fetchUserData(withQuery: graphQLQuery, variables: variables, success: { (resources: [AnyHashable: Any]?) in
            guard let resources = resources, let data = resources["data"] as? [String: Any], let me = data["me"] as? [String: Any] else { return }
            
            if let displayName = me["displayName"] as? String {
                print("\n\nDisplay Name: \(displayName)\n")
            }
            
            if let bitmoji = me["bitmoji"] as? [String: Any], let bitmojiAvatarUrl = bitmoji["avatar"] as? String {
                print("Bitmoji URL: \(bitmojiAvatarUrl)\n")
            }
            
            if let externalId = me["externalId"] as? String {
                print("External ID: \(externalId)\n\n")
            }
            
        }, failure: { (error: Error?, isUserLoggedOut: Bool) in
            print("ERROR RETRIEVING DATA FROM USER")
        })
    }
}
