//
//  Music.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 24.12.2022.
//

import Foundation
import FirebaseFirestoreSwift
struct MusicModel: Codable {
    let id: String?
    let name: String?
    let coverImageURL: URL?
    let singerID: String?
    let musicFileURL: URL?
    var data: Data? = nil
    var singerName:String?
//    var isDataLoading = false

    enum CodingKeys:String, CodingKey {
        case id
        case name
        case coverImageURL
        case singerID
        case musicFileURL
        case singerName
    }
    
}
extension MusicModel {
    static var testMusic = MusicModel(id: "xUUnNvU61eXBbdKcZsB7", name: "Mockingbird", coverImageURL: URL(string: "https://i1.sndcdn.com/artworks-000253338659-0pe5br-t500x500.jpg"), singerID: "UKizECUMopDapCPCNooA", musicFileURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/musicapp-219e7.appspot.com/o/musics%2Feminem%2FEminem%20-%20Mockingbird%20(Lyrics).mp3?alt=media&token=9c57cab5-10d1-40fc-8222-2cd5a9bf74e7"))
}
