//
//  TodoModel.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 27.12.2022.
//

import Foundation
struct Todo: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
