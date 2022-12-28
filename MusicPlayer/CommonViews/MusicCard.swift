//
//  MusicCard.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 26.12.2022.
//

import SwiftUI
import Kingfisher
struct MusicCard: View {
    var music: MusicModel?
    init(music: MusicModel?) {
        self.music = music
    }
    var body: some View {
        if(music == nil){
             EmptyView()
        } else {
            NavigationLink(destination: MusicView(music: music)){
                HStack{
                    KFImage(music?.coverImageURL).resizable().frame(width: 60,height: 60).cornerRadius(12)
                    VStack{
                        Text(music?.name ?? "-").bold()
                    
                    }
                    Spacer()
                    AddToFavoritesButton(musicID: music?.id)
                }
            }
        }
      
    }
}

struct MusicCard_Previews: PreviewProvider {
    static var previews: some View {
        MusicCard(music: MusicModel.testMusic)
    }
}
