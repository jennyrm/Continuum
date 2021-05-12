//
//  Post.swift
//  Continuum
//
//  Created by Jenny Morales on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import UIKit
import CloudKit

class Post {
    //MARK: - Properties
    var photoData: Data?
    let timestamp: Date
    let caption: String
    var comments: [Comment]
    let recordID: CKRecord.ID
    
    var photo: UIImage? {
        get {
            guard let photoData = photoData else { return nil }
            return UIImage(data: photoData)
        } set (newValue) {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    init(photo: UIImage?, timestamp: Date = Date(), caption: String, comments: [Comment] = [], recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.timestamp = timestamp
        self.caption = caption
        self.comments = comments
        self.recordID = recordID
        self.photo = photo
    }
    
}//End of class
