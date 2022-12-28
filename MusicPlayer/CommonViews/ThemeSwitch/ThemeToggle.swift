//
//  ThemeToggle.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 27.12.2022.
//

import SwiftUI

struct ThemeToggle: View {
    @State var isLightMode: Bool = false
    
    var body: some View {
        ZStack {
            background
            
            Toggle("", isOn: $isLightMode.animation(.easeInOut))
                .frame(width: 300, height: 100, alignment: .center)
                .toggleStyle(MyToggleStyle())
        }
        .preferredColorScheme(isLightMode ? .light : .dark)
    }
    
    @ViewBuilder private var background: some View {
        if isLightMode {
            Color("lightBg")
                .ignoresSafeArea()
        } else {
            Color("darkBg")
                .ignoresSafeArea()
        }
    }
}

struct ThemeToggle_Previews: PreviewProvider {
    static var previews: some View {
        ThemeToggle()
    }
}
