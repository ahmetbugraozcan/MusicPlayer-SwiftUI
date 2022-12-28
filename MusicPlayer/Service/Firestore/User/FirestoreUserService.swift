//
//  FirestoreUserService.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 23.12.2022.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase


class FirestoreUserService{
    fileprivate let db = Firestore.firestore()
    static let shared: FirestoreUserService = FirestoreUserService()
    
    fileprivate init(){
        
    }
    
    func saveUserToFirestore(user:User, completion: @escaping (UserModel?, Error?) -> Void){
        
        getUser(uid: user.uid, completion: { isExists, userModelFromGetUser in
            if isExists && userModelFromGetUser != nil {
                completion(userModelFromGetUser, nil)
                return
            }
            let ref = self.db.collection("users")
            ref.document(user.uid).setData([
                "name": user.displayName ?? "Unknown User",
                
                "photoURL": user.photoURL?.absoluteString,
                "phoneNumber": user.phoneNumber,
                "email": user.email,
                "uid": user.uid,
                "createdAt": Date.now,
            ], completion: { error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                let user = UserModel(uid: user.uid, name: user.displayName, photoURL: user.photoURL?.absoluteURL, email: user.email, phoneNumber: user.phoneNumber)
                completion(user, nil)
                
            })
        })
    }
    
    func getUser(uid: String, completion: @escaping (_ isExists:Bool, UserModel?) -> Void)  {
        db.collection("users").document(uid).getDocument(completion: { snapshot, error in
            if let error = error {
                completion(false, nil)
                print("catch ")
                return
            }
            
            guard let snapshot = snapshot else {
                completion(false, nil)
                print("catch ")
                return
            }
            
            do {
                let userData = try snapshot.data(as: UserModel.self)
                completion(true, userData)
                return
            } catch {
                print("catch ")
                completion(false, nil)
            }
            
//            let user =  JSONDecoder().decode(UserModel.self, from: snapshot.data(as: User.self))
//            completion(snapshot.exists, user)
        
            
        })
    }
    
    
    
}
