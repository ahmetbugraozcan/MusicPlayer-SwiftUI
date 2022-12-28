//
//  PlaylistModel.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 27.12.2022.
//

import Foundation

struct PlaylistModel: Codable {
    var musicIDs: [String?]
    var musics: [MusicModel?] = []
    var coverImage: URL?
    var name: String?
    var id: String?
    var createdBy: String?
    
    
    enum CodingKeys: CodingKey {
        case musicIDs
        case name
        case id
        case coverImage
        case createdBy
//        case createdAt
        
    }
}

extension PlaylistModel {
    static var testPlaylist: PlaylistModel = PlaylistModel(musicIDs: ["xUUnNvU61eXBbdKcZsB7"],musics: [MusicModel.testMusic], coverImage:URL(string: "https://media.pitchfork.com/photos/5e273d36d7f8cd0008150f58/1:1/w_600/eminem_music.jpg"),name: "Eminem Album 1", id: "tlFg4ah05v6J13oSn693", createdBy: "xOEundziBXOaBnmI3Z1SofI5wQj1" )
}
