//
//  DatabaseManager.swift
//  MessengerRealTime
//
//  Created by Mehmet Nafi ISLEK on 27.07.2021.
//
import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    /*
    public func test() {
        database.child("foo").setValue(["something": true])
     Burda anladığım kadarıyla firebase e bir json gönderiyor ve daha sonra bu jsonu çekebiliyoruz something true olarakta veri tutuyor jsonda string double tutulduğu gibi
    }*/
}
struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAdress: String
    //let profilePicture: URL
}
//MARK: Account Management
extension DatabaseManager {
    //aynı emailden var mı yok mu kontrolü eğer yoksa hesap oluşturabilir varsa oluşturamaz
    public func userExist(with email: String, completion: @escaping((Bool) ->Void )) {
        database.child(email).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != nil  else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    ///insert to new user to database
        public func insertUser(with user: ChatAppUser) {
            database.child(user.emailAdress).setValue(["firstName": user.firstName,"lastName":user.lastName])
        }
    }
