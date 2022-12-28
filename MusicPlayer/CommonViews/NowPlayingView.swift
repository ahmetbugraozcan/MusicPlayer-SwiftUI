import SwiftUI
import Kingfisher
struct NowPlayingView : View {
    @EnvironmentObject var musicViewModel: MusicViewModel
     
    var body: some View {
        if(musicViewModel.nowPlayingMusic == nil){
            EmptyView()
        } else {
            
           
                VStack {
                    Spacer()
                    HStack {
                        KFImage(musicViewModel.nowPlayingMusic?.coverImageURL).resizable().frame(width: 50, height: 50).cornerRadius(12).padding(6)
                        Text(musicViewModel.nowPlayingMusic?.name ?? "-")
                        Spacer()
                        AddToFavoritesButton(musicID: musicViewModel.nowPlayingMusic?.id)
                        if(musicViewModel.isMusicPlaying){
                            Image(systemName: "pause.fill").onTapGesture {
                                if(musicViewModel.player == nil) {return}
                                musicViewModel.playAudio()
                            }
                        } else {
                            Image(systemName: "play.fill").onTapGesture {
                                if(musicViewModel.player == nil) {return}
                                musicViewModel.playAudio()
                            }
                        }
                       
                    }.padding(.horizontal).background(Color("lightBg")).compositingGroup().shadow(radius: 2)
                    
                }
            
            }
        }
      
    
}

struct NowPlayingView_Previews: PreviewProvider {
    @StateObject var musicViewModel = MusicViewModel(music: MusicModel.testMusic)
    static var previews: some View {
        NowPlayingView().environmentObject( MusicViewModel(music: MusicModel.testMusic))
    }
}

