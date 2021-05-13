//
//  Comment.swift
//  Continuum
//
//  Created by Jenny Morales on 5/11/21.
//  Copyright © 2021 trevorAdcock. All rights reserved.
//

import Foundation
import CloudKit

class Comment {
    let text: String
    let timestamp: Date
    let recordID: CKRecord.ID
    weak var post: Post?
    
    var postReference: CKRecord.Reference? {
        guard let post = post else { return nil }
        return CKRecord.Reference(recordID: post.recordID, action: .deleteSelf)
    }
    
    init(text: String, timestamp: Date = Date(), post: Post?, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), postReference: CKRecord.Reference) {
        self.text = text
        self.timestamp = timestamp
        self.post = post
        self.recordID = recordID
        self.postReference = postReference
    }
}//End of class

//MARK: - Extensions
extension CKRecord {
    convenience init(comment: Comment) {
        self.init(recordType: CommentStrings.recordTypeKey, recordID: comment.recordID)
        self.setValuesForKeys([
            CommentStrings.textKey : comment.text,
            CommentStrings.timestampKey : comment.timestamp
        ])
        
    }
}//End of extension

extension Comment {
    convenience init?(ckRecord: CKRecord) {
        guard let text = ckRecord[CommentStrings.textKey] as? String,
              let timestamp = ckRecord[CommentStrings.timestampKey] as? Date else { return nil }
        
//        let postReference = ckRecord[]
        self.init(text: text, timestamp: timestamp, recordID: ckRecord.recordID, postReference: )
    }
}//End of extension
