//
//  AlbumModel.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 24.12.2022.
//

import Foundation

struct AlbumModel: Codable {
    var musicIDs: [String?]
    var musics: [MusicModel?] = []
    var albumCoverImage: URL?
    var name: String?
    var singerID: String?
    var uid: String?
    
    enum CodingKeys: CodingKey {
        case musicIDs
        case name
        case singerID
        case uid
        case albumCoverImage

        
    }
}

extension AlbumModel {
    static var testAlbum: AlbumModel = AlbumModel(musicIDs: ["xUUnNvU61eXBbdKcZsB7"],musics: [MusicModel.testMusic], albumCoverImage:URL(string: "https://media.pitchfork.com/photos/5e273d36d7f8cd0008150f58/1:1/w_600/eminem_music.jpg"),name: "Eminem Album 1",singerID:"UKizECUMopDapCPCNooA" ,uid: "tlFg4ah05v6J13oSn693" )
}
