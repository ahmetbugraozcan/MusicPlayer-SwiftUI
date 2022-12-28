//
//  Binding+Extension.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 28.12.2022.
//

import Foundation
import SwiftUI

extension Binding where Value == Bool {
    var not: Binding<Value> {
        Binding<Value>(
            get: { !self.wrappedValue },
            set: { self.wrappedValue = !$0 }
        )
    }
}
