//
//  HomeView.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 10.12.2022.
//

import SwiftUI
import MediaPlayer
import Kingfisher
struct MusicView: View {
    @EnvironmentObject var viewModel: MusicViewModel
    var music: MusicModel?
    var musics: [MusicModel?]?
    
    var body: some View {
        
        Group{
            if(viewModel.loading){
                ProgressView()
            } else {
                VStack{
                    
                    KFImage(viewModel.nowPlayingMusic?.coverImageURL).resizable().padding(0).frame(height: UIScreen.screenHeight * 0.5)
                    
                    VStack{
                      
                            HStack{
                                VStack(alignment: .leading){
                                    Text(viewModel.nowPlayingMusic?.name ?? "nil").bold().font(.title2)
                                    Text(viewModel.nowPlayingMusic?.singerName ?? "nil").bold().font(.subheadline)
                                }
                                Spacer()
                                if(viewModel.nowPlayingMusic != nil){
                                    AddToFavoritesButton(musicID: viewModel.nowPlayingMusic?.id)
                                }
                                
                                
                            }.frame(maxWidth: .infinity, alignment: .leading).padding(.vertical)
                        Slider(value: $viewModel.musicCurrentTime, in: 0...(viewModel.player?.duration ?? 0), onEditingChanged: { editing in
                            if(viewModel.loading) {return}
                            viewModel.isSliderDragging = editing



                            if !editing {
                                viewModel.player?.currentTime = viewModel.musicCurrentTime
                            }

                            if(round(viewModel.musicCurrentTime) == round(viewModel.player?.duration ?? 0)){
                                viewModel.checkMusicFinishAndStopIfEnd()
                            }

                        })
                        HStack{
                            Text(viewModel.musicCurrentTime.stringFromTimeInterval() ?? "-")
                            Spacer()
                            Text(viewModel.player?.duration.stringFromTimeInterval() ?? "-")
                        }
                        HStack{
                            Spacer()
                            
                            ZStack{
                                Circle().frame(width: 70,height: 70)
                                Group{
                                    if(viewModel.loading){
                                        ProgressView()
                                    }
                                    else if viewModel.isMusicPlaying{
                                        Image(systemName: "pause.fill").foregroundColor(.red)
                                    } else {
                                        Image(systemName: "play.fill").foregroundColor(.red)
                                    }
                                }
                               
                            }.onTapGesture {
                                if(viewModel.player == nil){
                                    return
                                }
                                viewModel.playAudio()
                            }
                            Spacer()
                          
                        }
                      
                        
                    }.frame(maxWidth: .infinity,maxHeight:.infinity, alignment: .top).background(.black)
                }.frame(maxHeight: .infinity,alignment: .top).foregroundColor(.white)
            }
        }.onAppear{
            UIApplication.shared.beginReceivingRemoteControlEvents()
            
            
          if(musics != nil){
                viewModel.musics = musics
                viewModel.music = musics?.first ?? nil
                viewModel.musicType = MusicType.list
                if(viewModel.nowPlayingMusic?.id == musics?.first??.id){
                    return
                }
                viewModel.task?.cancel()
                viewModel.initializeMusicSettings()
            }
            else if music != nil {
                if(viewModel.nowPlayingMusic?.id == music?.id){
                    return
                }
                viewModel.musicType = MusicType.single
                viewModel.task?.cancel()
                viewModel.music = music
                viewModel.initializeMusicSettings()
            }
           
        }.onDisappear{
            if(viewModel.loading){
                viewModel.task?.cancel()
                viewModel.loading = false
            }
        }
        
    }
}

struct MusicView_Previews: PreviewProvider {
    static var previews: some View {
        MusicView().environmentObject(MusicViewModel(music: MusicModel.testMusic))
    }
}
