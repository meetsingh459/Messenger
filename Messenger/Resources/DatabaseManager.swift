//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Manmeet Singh on 22/12/24.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    private static let url = "https://messenger-43c38-default-rtdb.asia-southeast1.firebasedatabase.app"
    static let shared = DatabaseManager()
    
    private let database = Database.database(url: DatabaseManager.url).reference()
    
    // MARK: Public functions
    
    public func validateUser(with email: String, completion: @escaping ((Bool) -> Void)) {
        database.child(email).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    public func createUser(_ user: ChatAppUser) {
        database.child(user.id).setValue([
            "firstName": user.firstName,
            "lastName": user.lastName,
            "email": user.email
        ])
    }
    
}


struct ChatAppUser {
    let firstName: String
    let lastName: String
    let email: String
    
    var id: String {
        var id = email.replacingOccurrences(of: ".", with: "-")
        id = id.replacingOccurrences(of: "@", with: "-")
        return id
    }
}
