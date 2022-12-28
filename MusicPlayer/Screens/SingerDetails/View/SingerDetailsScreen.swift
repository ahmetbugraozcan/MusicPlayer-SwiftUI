//
//  SingerDetailsScreen.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 26.12.2022.
//

import SwiftUI
import Kingfisher

struct SingerDetailsScreen: View {
    var singer: SingerModel?
    
    @EnvironmentObject var musicViewModel: MusicViewModel
    @EnvironmentObject var favoritesProvider: FavoritesProvider
    
    @StateObject var viewmodel = SingerDetailsViewModel()
    init(singerModel: SingerModel? = nil) {
        self.singer = singerModel
        
    }
    
    var body: some View {
        if(singer == nil){
            Text("Bir hata oluştu")
        } else {
            ZStack{
                VStack(alignment: .leading){
                    ZStack(alignment: .bottomLeading){
                        KFImage(singer!.photoURL).resizable().ignoresSafeArea().frame(maxHeight: UIScreen.screenHeight * 0.4)
                        HStack {
                            Text(singer?.name ?? "undef").bold().foregroundColor(.white).font(.title).padding(.leading).shadow(radius: 2)
                            Spacer()
//                            NavigationLink(destination: MusicView(musics:viewmodel.musics)){
//                                ZStack{
//                                    Circle()
//                                        .fill(.green)
//                                    Image(systemName: "play.fill").foregroundColor(.white).font(.title)
//                                }.frame(width: 60, height: 60).offset(y: 30.0).padding(.trailing, 12)
//                            }
                        }
                    }
                    Text("Şarkılar").bold().font(.title2).padding()

                    if(!viewmodel.loading){
                        List(viewmodel.musics ?? [],id: \.self?.id){music in
                            MusicCard(music: music)
                        }.listStyle(.plain)
                    }
               
                }.frame(maxHeight: .infinity,alignment: .top)
                if(musicViewModel.nowPlayingMusic != nil){
                    Spacer().frame(height: 70)
                }
                NowPlayingView()
            }.onAppear{
                viewmodel.singer = singer
            }
        }
        
    }}

struct SingerDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SingerDetailsScreen(singerModel: SingerModel.test).environmentObject(MusicViewModel(music: MusicModel.testMusic)).environmentObject(FavoritesProvider())
    }
}
