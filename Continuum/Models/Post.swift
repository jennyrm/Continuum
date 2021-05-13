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
    
    var photoData: Data?
    
    var imageAsset: CKAsset? {
        get {
            let tempDirectory = NSTemporaryDirectory()
            let tempDirectoryURL = URL(fileURLWithPath: tempDirectory)
            let fileURL = tempDirectoryURL.appendingPathComponent(UUID().uuidString).appendingPathExtension("jpg")
            do {
                try photoData?.write(to: fileURL)
            } catch let error {
                print("Error writing to temp url \(error) \(error.localizedDescription)")
            }
            return CKAsset(fileURL: fileURL)
        }
    }
    
    init(timestamp: Date = Date(), caption: String, comments: [Comment] = [], recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), photo: UIImage? = nil) {
        self.timestamp = timestamp
        self.caption = caption
        self.comments = comments
        self.recordID = recordID
        self.photo = photo
    }
    
}//End of class

//MARK: - Extensions
extension Post: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        return caption.lowercased().contains(searchTerm.lowercased()) ? true : false
    }
    
}//End of extension

extension CKRecord {
    convenience init(post: Post) {
        self.init(recordType: PostStrings.recordTypeKey, recordID: post.recordID)
        self.setValuesForKeys([
            PostStrings.timestampKey : post.timestamp,
            PostStrings.captionKey : post.caption,
            PostStrings.imageAssetKey : post.imageAsset
        ])
    }
}//End of extension

extension Post {
    convenience init?(ckRecord: CKRecord) {
        guard let timestamp = ckRecord[PostStrings.timestampKey] as? Date,
              let caption = ckRecord[PostStrings.captionKey] as? String else { return nil }
        
        var foundPhoto: UIImage?
        
        if let photoAsset = ckRecord[PostStrings.photoKey] as? CKAsset {
            do {
                let data = try Data(contentsOf: photoAsset.fileURL)
                foundPhoto = UIImage(data: data)
            } catch {
                print("Could not transform asset to data")
            }
        }
        
        self.init(timestamp: timestamp, caption: caption, comments: [], recordID: ckRecord.recordID, photo: foundPhoto)
    }
}//End of extension
