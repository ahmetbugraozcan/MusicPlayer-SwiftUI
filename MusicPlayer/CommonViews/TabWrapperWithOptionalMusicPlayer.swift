//
//  TabWrapperWithOptionalMusicPlayer.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 25.12.2022.
//

import SwiftUI

struct TabWrapperWithOptionalMusicPlayer<Content> : View where Content : View {

    var showPlayer : Bool
    var content : Content
    
    init(showPlayer : Bool, @ViewBuilder content: () -> Content) {
        self.showPlayer = showPlayer
        self.content = content()
    }
        
    var body: some View {
        ZStack(alignment: .bottom) {
            content
            if showPlayer {
                VStack{}.frame(width: 200,height: 50).background(.red)
            }
        }
    }
}


struct TabWrapperWithOptionalMusicPlayer_Previews: PreviewProvider {
    static var previews: some View {
        TabWrapperWithOptionalMusicPlayer(showPlayer: true){
            Text("Hello")
        }
    }
}
