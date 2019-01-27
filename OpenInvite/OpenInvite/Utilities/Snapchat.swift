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
                Snapchat.retrieveData() { success in
                    print(success)
                }
            }
        }
    }
    
    static func retrieveData(completion: @escaping (_ success: Bool) -> Void) {
        let graphQLQuery = "{me{displayName, bitmoji{avatar}, externalId}}"
        let variables = ["page": "bitmoji"]
        
        SCSDKLoginClient.fetchUserData(withQuery: graphQLQuery, variables: variables, success: { (resources: [AnyHashable: Any]?) in
            guard let resources = resources, let data = resources["data"] as? [String: Any], let me = data["me"] as? [String: Any] else { return }
            
            if let displayName = me["displayName"] as? String {
                print("\n\nDisplay Name: \(displayName)\n")
                user.displayName = displayName
            }
            
            if let bitmoji = me["bitmoji"] as? [String: Any], let bitmojiAvatarUrl = bitmoji["avatar"] as? String {
                print("Bitmoji URL: \(bitmojiAvatarUrl)\n")
                user.imageURL = bitmojiAvatarUrl
            }
            
            if let externalId = me["externalId"] as? String {
                print("External ID: \(externalId)\n\n")
                user.id = externalId.replacingOccurrences(of: "/", with: "|")
            }
            user.save()
            completion(true)
            
        }, failure: { (error: Error?, isUserLoggedOut: Bool) in
            print("ERROR RETRIEVING DATA FROM USER")
            completion(false)
        })
    }
}
