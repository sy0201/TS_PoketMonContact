//
//  ContactDataManager.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/10/24.
//

import CoreData
import UIKit

final class ContactDataManager {
    static let shared = ContactDataManager()
    
    private init() {}

    private var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate 접근 실패")
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    // create
    func createContactData(name: String, phoneNumber: String, profileImage: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: ContactEntity.className, in: context) else {
            print("Entity not found")
            return
        }
        
        let newContact = NSManagedObject(entity: entity, insertInto: context)

        newContact.setValue(name, forKey: ContactEntity.Key.name)
        newContact.setValue(phoneNumber, forKey: ContactEntity.Key.phoneNumber)
        newContact.setValue(profileImage, forKey: ContactEntity.Key.profileImage)
        
        do {
            try self.context.save()
            print("데이터 저장 성공")
        } catch {
            print("데이터 저장 실패\(error.localizedDescription)")
        }
    }
    
    // read
    func readContactData() -> [ContactEntity] {
        let fetchRequest: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()

        do {
            return try self.context.fetch(fetchRequest)
        }
        catch {
            print("데이터 읽기 실패")
            return []
        }
    }
    
    // update
    func updateContactData(contact: ContactEntity, name: String, phoneNumber: String, profileImage: String) {
        contact.setValue(name, forKey: ContactEntity.Key.name)
        contact.setValue(phoneNumber, forKey: ContactEntity.Key.phoneNumber)
        
        // profileImage가 빈 값일 경우 기존 값 유지
        let finalImageURL = (profileImage.isEmpty || profileImage == "default_image_url") ? contact.profileImage : profileImage
        contact.setValue(finalImageURL, forKey: ContactEntity.Key.profileImage)
        
        do {
            try self.context.save()
            print("데이터 업데이트 성공")
        } catch {
            print("데이터 업데이트 실패: \(error)")
        }
    }

    
    // delete
    func deleteContactData(name: String) {
        let fetchRequest = ContactEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try self.context.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                self.context.delete(data)
            }
            print("데이터 삭제 성공")
            
        }  catch {
            print("데이터 삭제 실패")
        }
    }
}
