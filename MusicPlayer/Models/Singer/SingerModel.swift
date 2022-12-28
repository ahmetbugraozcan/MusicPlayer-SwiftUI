//
//  SingerModek.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 24.12.2022.
//

import Foundation

struct SingerModel: Codable {
    var name: String?
    var photoURL: URL?
    var uid: String?
    var songs: [MusicModel?]? = []
    enum CodingKeys: CodingKey {
        case name
        case photoURL
        case uid
    }
    
}

extension SingerModel {
    static var test = SingerModel(name: "eminem",photoURL: URL(string: "asdasd"), uid: "uid")
}
