//
//  FirestoreMusicService.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 24.12.2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirestoreMusicService {
    private var db = Firestore.firestore()
    static let shared = FirestoreMusicService()
    fileprivate init(){
        
    }
    
    func getMusicDetails(id: String?, completion: @escaping (MusicModel?) -> Void){
        guard let id = id else {
            completion(nil)
            return
        }
      
        db.collection("musics").document(id).getDocument(completion: { snapshot, error in
            do{
                guard let data = try snapshot?.data(as: MusicModel.self) else {
                    completion(nil)
                    return
                }
                
                completion(data)
                return
            } catch {
                print("ERROR GET MUSIC DETAIL")
                completion(nil)
                return  
            }
        
    })
    }
    
    func getMusics(ids: [String?]?, completion: @escaping ([MusicModel?]?) -> Void){
        guard let ids = ids else {
            completion(nil)
            return
        }
      
        db.collection("musics").whereField("id", in: ["xUUnNvU61eXBbdKcZsB7", "zhusGy4yZpqfKosTSzJh"]).getDocuments { snapshot, error in
            guard let snapshot = snapshot else {
                return completion(nil)
            }
            var dataToReturn: [MusicModel?]?
            snapshot.documents.forEach { doc in
                do{
                    dataToReturn?.append(try doc.data(as: MusicModel.self))
                } catch{
                    print("ERROR PARSING DATA \(error)")
                }
            }
            
            completion(dataToReturn)
            print("DATATORETURN SIZE IS \(dataToReturn)")
        return
        }
    }
}
