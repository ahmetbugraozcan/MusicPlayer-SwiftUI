//
//  AlbumDetailsScreen.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 24.12.2022.
//

import SwiftUI
import Kingfisher
struct AlbumDetailsScreen: View {
    var album: AlbumModel?
    @EnvironmentObject var musicViewModel: MusicViewModel
    @EnvironmentObject var favoritesProvider: FavoritesProvider
    init(album: AlbumModel? = nil) {
        self.album = album
    }
    
    var body: some View {
        if(album == nil){
            Text("Bir hata oluştu")
        } else {
            ZStack{
                VStack(alignment: .leading){
                    ZStack(alignment: .bottomLeading){
                        KFImage(album!.albumCoverImage).resizable().ignoresSafeArea().frame(maxHeight: UIScreen.screenHeight * 0.4)
                        HStack {
                            Text(album?.name ?? "undef").bold().foregroundColor(.white).font(.title).padding(.leading)
                            Spacer()
//                            ZStack{
//                                Circle()
//                                    .fill(.green)
//                                Image(systemName: "play.fill").foregroundColor(.white).font(.title)
//                            }.frame(width: 60, height: 60).offset(y: 30.0).padding(.trailing, 12)
                        }
                    }
                    Text("Şarkılar").bold().font(.title2).padding()
                   
                    List(album!.musics,id: \.self?.id){music in
                        MusicCard(music: music)
                    }.listStyle(.plain)
                }.frame(maxHeight: .infinity,alignment: .top)
                NowPlayingView()
            }
        }
        
    }
}

struct AlbumDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailsScreen(album: AlbumModel.testAlbum)
    }
}
