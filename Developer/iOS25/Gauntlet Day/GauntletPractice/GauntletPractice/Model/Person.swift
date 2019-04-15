//
//  Person.swift
//  GauntletPractice
//
//  Created by Colin Smith on 4/14/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit
import CloudKit

class Person {
    //MARK:-Properties
    let name: String
    let title: String
    let linkedIn: String
    let bio: String
    let image: UIImage
    let recordID: CKRecord.ID
    
    //Initializer
    init(name: String, title: String, linkedIn: String, bio: String, image: UIImage, recordID: CKRecord.ID=CKRecord.ID(recordName: UUID().uuidString)){
        self.name = name
        self.title = title
        self.bio = bio
        self.image = image
        self.linkedIn = linkedIn
        self.recordID = recordID
    }
    
    //Convenience init for recordID
    convenience init?(ckRecord: CKRecord){
        guard let name = ckRecord[Constants.nameKey] as? String,
            let title = ckRecord[Constants.titleKey] as? String,
            let linkedIn = ckRecord[Constants.linkedInKey] as? String,
            let image = ckRecord[Constants.imageKey] as? UIImage,
            let bio = ckRecord[Constants.bioKey] as? String else {return nil}
        
        self.init( name: name, title: title, linkedIn: linkedIn, bio: bio, image: image, recordID: ckRecord.recordID)
    }
} // End of Person Class


//Extension on CKRecord
extension CKRecord{
    convenience init(person: Person){
        self.init(recordType: Constants.PersonRecordType, recordID: person.recordID)
        self.setValue(person.name, forKey: Constants.nameKey)
        self.setValue(person.linkedIn, forKey: Constants.linkedInKey)
        self.setValue(person.bio, forKey: Constants.bioKey)
        self.setValue(person.image, forKey: Constants.imageKey)
    }
}

//Person Constants Struct to deal with the Keys
struct Constants {
    static let PersonRecordType = "Person"
    static let nameKey = "Name"
    static let linkedInKey = "LinkedIn"
    static let titleKey = "Title"
    static let imageKey = "Email"
    static let bioKey = "Bio"
    
}
