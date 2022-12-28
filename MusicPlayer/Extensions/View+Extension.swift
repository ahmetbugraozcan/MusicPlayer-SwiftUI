//
//  View+Extension.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 25.12.2022.
//

import SwiftUI

extension View{
    func toastView(toast: Binding<ToastModel?>) -> some View {
         self.modifier(ToastModifier(toast: toast))
     }
}
