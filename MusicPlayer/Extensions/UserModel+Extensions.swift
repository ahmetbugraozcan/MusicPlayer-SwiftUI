//
//  String+Extensions.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 23.12.2022.
//

import Foundation


extension UserModel {
    var firstName: String {
        return self.name?.components(separatedBy: " ").first ?? ""
    }
}
