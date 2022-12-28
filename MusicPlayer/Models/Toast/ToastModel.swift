//
//  ToastModel.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 25.12.2022.
//


struct ToastModel: Equatable {
    var type: ToastStyle
    var title: String
    var message: String
    var duration: Double = 3
}
