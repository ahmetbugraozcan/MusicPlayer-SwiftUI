//
//  FirestoreMusicianService.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 26.12.2022.
//

import Foundation

import FirebaseFirestore
import Firebase
class FirestoreSingerService {
    private var db = Firestore.firestore()
    static var shared: FirestoreSingerService = FirestoreSingerService()
    fileprivate init(){
        
    }
    
    func getSingers(completion: @escaping ([SingerModel]?) -> Void){
        var elements: [SingerModel]? = []
        db.collection("singers").getDocuments(completion: { snapshot, error in
            do{
                guard let data = snapshot else {
                    return completion(nil)
                }
                
                data.documents.forEach { doc in
                    do{
                        var element = try doc.data(as: SingerModel.self)
                        elements?.append(element)
                        
                    } catch{
                        print("Element parse edilemedi")
                    }
                }
                
                completion(elements)
                return
            } catch {
                print("ERROR GET MUSUCIANS DETAIL")
                completion(nil)
                return
            }
        
    })
    }
    
    func getSingerMusics(id: String?, completion: @escaping([MusicModel?]?, Error?) -> Void){
        
        guard let id = id else {
            return
        }
        var musics: [MusicModel?]? = []
        db.collection("musics").whereField("singerID", isEqualTo: id).getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            snapshot?.documents.forEach({ doc in
                do{
                    var element = try doc.data(as: MusicModel.self)
                    musics?.append(element)
                    
                } catch{
                    print("Element parse edilemedi")
                }
            })
            
            completion(musics, nil)
            return
        }
    }
}
