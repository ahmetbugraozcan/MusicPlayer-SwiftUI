//
//  FirebaseAuth.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 22.12.2022.
//

import Firebase
import GoogleSignIn
class FirebaseAuth  {
    
    static let shared: FirebaseAuth = FirebaseAuth()
    
    fileprivate init() {
        
    }
    
    
    func signIn(completion: @escaping (User?, Error?) -> Void){
        guard let presenting = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
 
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard
                let idToken = result?.user.idToken,
                let accessToken = result?.user.accessToken
            else {
                completion(nil, BaseError("Giriş yapılırken hata"))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
          
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                
                    completion(nil, error)
                    return
                }
                
                guard let user = result?.user else {
                    completion(nil, BaseError("Giriş yapılırken hata"))
                    return
                }
      
                completion(user, nil)
            }
            
            
        }
    }
    
    
}

