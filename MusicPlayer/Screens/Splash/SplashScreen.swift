//
//  SplashScreen.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 23.12.2022.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack{
            Text("Müzik Uygulamasına Hoşgeldin.").font(.title).bold().padding().multilineTextAlignment(.center)
            Text("Yönlendiriliyorsunuz...")
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).background{
            Image("musicwallpaper").resizable().ignoresSafeArea()
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
