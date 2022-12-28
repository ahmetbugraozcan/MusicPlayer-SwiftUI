//
//  FirestorePlaylistService.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 27.12.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirestorePlaylistService {
    fileprivate let db = Firestore.firestore()
    static var shared = FirestorePlaylistService()
    
    fileprivate init(){
        
    }
    
    func getPlaylists(userID:String ,completion: @escaping ([PlaylistModel?]?, Error?) -> Void ){
        db.collection("playlists").whereField("createdBy", isEqualTo: userID).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                completion(nil, error)
                return
            }

            print("snapshots is \(snapshot)")
            let playlists = documents.compactMap { snapshot in
                do{
                    return try? snapshot.data(as: PlaylistModel.self)
                } catch{
                    print("SOME ERROR OCCURED ERROR IS \(error)")
                }
            }
            
            completion(playlists, nil)
            return
        }
    }
}
