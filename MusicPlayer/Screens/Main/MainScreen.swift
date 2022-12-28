//
//  MainScreen.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 23.12.2022.
//

import SwiftUI

struct MainScreen: View {
    
    @StateObject var favoritesProvider: FavoritesProvider = FavoritesProvider()
    @StateObject var musicViewModel: MusicViewModel = MusicViewModel(music: nil)
    @StateObject var volumeListener: VolumeListener = VolumeListener()
    var body: some View {
        
        TabView{
            HomeView().tabItem {
                    Label("Ana Sayfa", systemImage: "house.fill")
                }
            
            FavoritesScreen().tabItem {
                Label("Favorilerim", systemImage: "heart.fill")
            }
            ProfileScreen().tabItem {
                Label("Profil", systemImage: "person.crop.circle.fill")
            }
        }.environmentObject(musicViewModel).environmentObject(favoritesProvider).onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue:"SystemVolumeDidChange"))){_ in
            print("system volume has been changed")
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
