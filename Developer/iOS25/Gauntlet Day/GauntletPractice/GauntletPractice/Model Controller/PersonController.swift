//
//  ContactController.swift
//  GauntletPractice
//
//  Created by Colin Smith on 4/14/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit
import CloudKit

class PersonController {
    // Singleton Shared Instance
    static let shared = PersonController()
    
    var people: [Person] = [Person(name: "Colin Smith", title: "iOS Developer", linkedIn: "https://www.linkedin.com/in/colintsmith/", bio: "Moved here from the East Coast. Used to teach Math to kids in West Virginia. Sister convinced me to be a developer instead.", image: UIImage(named: "Colin") ?? UIImage())]
    
    let publicDB = CKContainer.default().publicCloudDatabase
    let privateDV = CKContainer.default().privateCloudDatabase
    
    //Create
    func createPerson(name: String, title: String, linkedIn: String, bio: String, image: UIImage, completion: @escaping (Person?) -> Void){
        let newPerson = Person(name: name, title: title, linkedIn: linkedIn, bio: bio, image: image)
        let newRecord = CKRecord(person: newPerson)
        publicDB.save(newRecord) { (record, error) in
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            guard let record = record else {return}
            let person = Person(ckRecord: record)
            guard let unwrappedPerson = person else {return}
            self.people.append(unwrappedPerson)
            completion(unwrappedPerson)
        }
    }
    //Fetch
    func fetchAllPersons(completion: @escaping ([Person]?) -> Void){
            let predicate = NSPredicate(value: true)
            let query = CKQuery(recordType: Constants.PersonRecordType, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            guard let records = records else {return}
            let returnedPersons: [Person] = records.compactMap{Person(ckRecord: $0)}
            self.people = returnedPersons
            completion(returnedPersons)
        }
    }
    //Update
    func update(nameToUpdate: String, titleToUpdate: String, linkedInToUpdate: String, bioToUpdate: String, imageToUpdate: UIImage, person: Person, completion: @escaping (Bool?)->Void){
        publicDB.fetch(withRecordID: person.recordID) { (record, error) in
            if let error = error {
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            record?.setValue(nameToUpdate, forKeyPath: Constants.nameKey)
            record?.setValue(titleToUpdate, forKey: Constants.titleKey)
            record?.setValue(linkedInToUpdate, forKeyPath: Constants.linkedInKey)
            record?.setValue(bioToUpdate, forKeyPath: Constants.bioKey)
            record?.setValue(imageToUpdate, forKeyPath: Constants.imageKey)
            
            guard let record = record else {return}
            
            
            let updated = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
            
            updated.savePolicy = .changedKeys
            updated.queuePriority = .high
            updated.qualityOfService = .userInitiated
            updated.modifyRecordsCompletionBlock = {(records, recordIDs,error) in
                completion(true)
            }
            self.publicDB.add(updated)
        }
    }
}
