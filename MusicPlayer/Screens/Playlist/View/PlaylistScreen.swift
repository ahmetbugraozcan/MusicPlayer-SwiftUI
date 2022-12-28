
import SwiftUI
import Kingfisher
struct PlaylistScreen: View {
    var playlist: PlaylistModel?
    @EnvironmentObject var musicViewModel: MusicViewModel
    @EnvironmentObject var favoritesProvider: FavoritesProvider
    init(playlist: PlaylistModel? = nil) {
        self.playlist = playlist
    }
    
    var body: some View {
        if(playlist == nil){
            Text("Bir hata oluştu")
        } else {
            ZStack{
                VStack(alignment: .leading){
                    ZStack(alignment: .bottomLeading){
                        KFImage(playlist!.coverImage).resizable().ignoresSafeArea().frame(maxHeight: UIScreen.screenHeight * 0.4)
                        HStack {
                            Text(playlist?.name ?? "undef").bold().foregroundColor(.white).font(.title).padding(.leading)
                            Spacer()
//                            ZStack{
//                                Circle()
//                                    .fill(.green)
//                                Image(systemName: "play.fill").foregroundColor(.white).font(.title)
//                            }.frame(width: 60, height: 60).offset(y: 30.0).padding(.trailing, 12)
                        }
                    }
                    Text("Şarkılar").bold().font(.title2).padding()
                   
                    List(playlist!.musics,id: \.self?.id){music in
                        MusicCard(music: music)
                    }.listStyle(.plain)
                }.frame(maxHeight: .infinity,alignment: .top)
                NowPlayingView()
            }
        }
        
    }
}

struct PlaylistScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistScreen(playlist: PlaylistModel.testPlaylist)
    }
}
