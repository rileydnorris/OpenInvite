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

/// Test function
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

/// Writes to a specified document
func setDocument(_ collectionName : String, _ id : String, _ data : [String : Any])  {
    let docRef: DocumentReference = db.collection(collectionName).document(id)
    docRef.setData(data, merge : true)
}


/// Retrieves a document after being given an ID
func getDocumentByID(_ collectionName : String, _ docID : String, completion: @escaping (DocumentSnapshot?, Error?) -> Void) {
    let docRef: DocumentReference = db.collection("users").document(docID)
    docRef.getDocument( completion: completion )
}

/// Retrieves an entire collection
func getCollectionDocuments(_ collectionName : String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
    let collectRef: CollectionReference = db.collection(collectionName)
    collectRef.getDocuments( completion: completion )
}


