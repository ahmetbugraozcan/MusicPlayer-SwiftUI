//
//  AuthenticationViewModel.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 22.12.2022.
//

import Foundation
import GoogleSignIn
import Firebase
class AuthenticationViewModel: ObservableObject {
    @Published var userModel: UserModel?
    @Published var isLoggingIn = false
    init() {
//        UserDefaults.standard.removeObject(forKey: UserDefaultKeys.User.rawValue)
        checkIfUserLoggedIn()
    }
    
 
    @Published var state: SignInState = .signedOut
    
    func checkIfUserLoggedIn(){
        self.state = SignInState.loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            
            guard let userID = UserDefaults.standard.string(forKey: UserDefaultKeys.User.rawValue) else {
                self.state = SignInState.signedOut
                return
            }
            
            FirestoreUserService.shared.getUser(uid: userID) { isExists, userModel in
                if !isExists || userModel == nil {
                    self.state = SignInState.signedIn
                    return
                }
                
                self.userModel = userModel
                self.state = SignInState.signedIn
            }
        })
    }
    
    func signIn(completion: @escaping (Bool, Error?) -> Void  ){
       isLoggingIn = true
        FirebaseAuth.shared.signIn { user, error in
            if let error = error {
                print("Some error occured while signin : \(error.localizedDescription)")
                self.state = SignInState.signedOut
                self.isLoggingIn = false
                completion(false, error)
                return
            }
            
            
            FirestoreUserService.shared.saveUserToFirestore(user: user!) { userModel, error in
                if let error = error {
                    completion(false, error)
                    self.state = SignInState.signedOut
                    self.isLoggingIn = false
                    return
                }
                
                self.userModel = userModel
                UserDefaults.standard.set(userModel!.uid, forKey: UserDefaultKeys.User.rawValue)
                self.state = SignInState.signedIn
                self.isLoggingIn = false
                completion(true, nil)
                return
            }
        }
    }

}
enum SignInState: String{
    case signedIn = "signedIn"
    case loading = "loading" // Splash screende kullanılan
    case signingIn = "signingIn" // Loginde kullanılan
    case signedOut = "signedOut"
}
