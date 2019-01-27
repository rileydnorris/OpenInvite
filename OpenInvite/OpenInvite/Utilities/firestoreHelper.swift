//
//  firestoreHelper.swift
//  OpenInvite
//
//  Created by Kaleb Lewis on 1/26/19.
//  Copyright © 2019 Riley Norris. All rights reserved.
//

import Foundation
import Firebase

/// Writes to a specified document
func setDocument(_ collectionName : String, _ id : String, _ data : [String : Any])  {
    print(id)
    print(collectionName)
    print(data)
    let docRef: DocumentReference = db.collection(collectionName).document(id)
    docRef.setData(data, merge : true)
}

/// Retrieves a document after being given an ID
func getDocumentByID(_ collectionName : String, _ docID : String, completion: @escaping (DocumentSnapshot?, Error?) -> Void) {
    let docRef: DocumentReference = db.collection(collectionName).document(docID)
    docRef.getDocument( completion: completion )
}

/// Retrieves an entire collection
func getCollectionDocuments(_ collectionName : String, completion: @escaping (QuerySnapshot?, Error?) -> Void) {
    let collectRef: CollectionReference = db.collection(collectionName)
    collectRef.getDocuments( completion: completion )
}


