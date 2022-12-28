//
//  UserModel.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 23.12.2022.
//

import Foundation


struct UserModel: Codable {
    let uid: String?
    let name: String?
    let photoURL: URL?
    let email: String?
    let phoneNumber: String?
    
    enum CodingKeys:String, CodingKey {
        case uid
        case name
        case photoURL
        case email
        case phoneNumber
    }
    
    
}
