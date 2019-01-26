//
//  firestoreHelper.swift
//  OpenInvite
//
//  Created by Kaleb Lewis on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import Foundation
import Firebase

let db = Firestore.firestore()

func firebaseTest() {
    
    // Add a new document with a generated ID
    var ref: DocumentReference? = nil
    ref = db.collection("users").addDocument(data: [
        "first": "Ada",
        "last": "Lovelace",
        "born": 1815
    ]) { err in
        if let err = err {
            print("Error adding document: \(err)")
        } else {
            print("Document added with ID: \(ref!.documentID)")
        }
    }
}

func setDocument(_ collectionName : String, _ id : String, _ data : [String : Any])  {
    let docRef: DocumentReference = db.collection(collectionName).document(id)
    docRef.setData(data, merge : true)
}

func getDocumentByID(_ collectionName : String, _ userID : String, completion: @escaping (DocumentSnapshot?, Error?) -> Void) {
    let userDocRef: DocumentReference = db.collection("users").document(userID)
    userDocRef.getDocument( completion: completion )
//        { (document, error) in
//        if let document = document, document.exists {
//            let data = document.data() ?? nil
//            completion(data!)
////            print("Document data: \(data)")
//        } else {
//            print("Document does not exist")
//        }
    }
//}


