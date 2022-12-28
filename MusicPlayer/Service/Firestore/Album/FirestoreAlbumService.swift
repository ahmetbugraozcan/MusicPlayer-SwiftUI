//
//  FirestoreAlbumService.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 24.12.2022.
//

import Foundation

import Firebase
import FirebaseFirestoreSwift

class FirestoreAlbumService {
    fileprivate let db = Firestore.firestore()
    static var shared = FirestoreAlbumService()
    
    fileprivate init(){
        
    }
    
    func getAlbums(completion: @escaping ([AlbumModel?]?, Error?) -> Void ){
        db.collection("albums").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                completion(nil, error)
                return
            }

            
            let albums = documents.compactMap { snapshot in
                return try? snapshot.data(as: AlbumModel.self)
            }
            
            
            
            completion(albums, nil)
            return
        }
    }
}
