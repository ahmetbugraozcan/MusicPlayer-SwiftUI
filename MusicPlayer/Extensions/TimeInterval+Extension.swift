//
//  TimeInterval+Extension.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 11.12.2022.
//

import Foundation
extension TimeInterval {


    func stringFromTimeInterval() -> String {
            
               let time = NSInteger(self)
               let seconds = time % 60
               let minutes = (time / 60) % 60
               return String(format: "%0.2d:%0.2d",minutes,seconds)

           }
}

