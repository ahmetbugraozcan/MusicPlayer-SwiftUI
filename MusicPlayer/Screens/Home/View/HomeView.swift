//
//  HomeView.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 20.12.2022.
//

import SwiftUI
import Kingfisher
struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var musicViewModel: MusicViewModel
    @StateObject var homeViewModel = HomeViewModel()
    var body: some View {
        NavigationView {
            
            ZStack{
                
                ScrollView {
                    VStack {
                        HStack {
                            
                            VStack(alignment: .leading){
                                Text("Merhaba \(authViewModel.userModel?.firstName ?? "-")").font(.title)
                                Text("Hadi bugün güzel bir şeyler dinleyelim.").font(.callout)
                            }
                            Spacer()
                            
                            Image(systemName: "bell")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.black)
                                .clipShape(Circle()).onTapGesture {
                                    print("NOTIFICATION SEND")
                                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                        if success {
                                            let content = UNMutableNotificationContent()
                                            content.title = "Bildirim"
                                            content.subtitle = "Test Bildirimi"
                                            content.sound = UNNotificationSound.default

                                            // show this notification five seconds from now
                                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                                            // choose a random identifier
                                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                                            // add our notification request
                                            UNUserNotificationCenter.current().add(request)
                                        } else if let error = error {
                                            print(error.localizedDescription)
                                        }
                                    }
                                  
                                }
                            
                        }.padding(.all)
                        VStack {
                            HStack {
                                Text("Popüler Sanatçılar").font(.headline)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }.padding(.all)
                            ScrollView(.horizontal, showsIndicators: false) {
                                if(homeViewModel.isSingersLoading){
                                    Text("Loading").padding(.all)
                                } else {
                                    HStack(spacing: 18) {
                                        ForEach(homeViewModel.singers ?? [] ,id: \.uid) { i in
                                            NavigationLink(destination: SingerDetailsScreen(singerModel: i)){
                                                VStack{
                                                    KFImage(i.photoURL).resizable().frame(width: 70, height: 70).clipShape(Circle())
                                                    Text(i.name ?? "-")
                                                }
                                            }.buttonStyle(.plain)
                                        }
                                    }.padding(.horizontal)
                                }
                               
                            }
                        }
                        
                        
                        VStack {
                            HStack {
                                Text("Popüler Albümler").font(.headline)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }.padding(.all)
                            ScrollView(.horizontal, showsIndicators: false) {
                                if(homeViewModel.isAlbumsLoading){
                                    Text("Loading").padding(.all)
                                } else {
                                    
                                    HStack {
                                        ForEach(homeViewModel.albums ?? [], id: \.self?.uid) { album in
                                            NavigationLink(destination: AlbumDetailsScreen(album: album)){
                                                VStack(alignment: .leading){
                                                    KFImage(album?.albumCoverImage).resizable().frame(width: 160,height: 160).cornerRadius(24.0)
                                            
                                                    Text(album?.name ?? "-").padding(.horizontal) .frame(width: 160, alignment: .leading)
                                                    
                                                }.frame(width: 160)
                                            }.buttonStyle(.plain)
                                        }
                                    }.padding(.horizontal)
                                }
                            }
                            
                        }
                    }.padding(.vertical)
                    
                    
                    
                    VStack {
                        HStack {
                            Text("Çalma Listelerin").font(.headline)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }.padding(.all)
                        ScrollView(.horizontal, showsIndicators: false) {
                            if(homeViewModel.isPlaylistsLoading){
                                Text("Loading").padding(.all)
                            } else {
                                
                                HStack {
                                    ForEach(homeViewModel.playlists ?? [], id: \.self?.id) { playlist in
                                        NavigationLink(destination: PlaylistScreen(playlist: playlist)){
                                            VStack(alignment: .leading){
                                                KFImage(playlist?.coverImage).resizable().frame(width: 160,height: 160).cornerRadius(24.0)
                                        
                                                Text(playlist?.name ?? "-").padding(.horizontal) .frame(width: 160, alignment: .leading)
                                                
                                            }.frame(width: 160)
                                        }.buttonStyle(.plain)
                                    }
                                }.padding(.horizontal)
                            }
                        }
                        
                    }
                    if(musicViewModel.nowPlayingMusic != nil){
                        Spacer().frame(height:70)
                    }
                }
                
             
                    NowPlayingView()
                 
            }
        }
    }
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AuthenticationViewModel()).environmentObject(MusicViewModel(music: MusicModel.testMusic
                                                                                                ))
    }
}
