//
//  HomeViewModel.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 24.12.2022.
//

import SwiftUI

class HomeViewModel:ObservableObject{
    @Published var albums: [AlbumModel?]?
    @Published var isAlbumsLoading: Bool = false
    
    @Published var isSingersLoading: Bool = false
    @Published var singers: [SingerModel]?
    
    @Published var isPlaylistsLoading: Bool = false
    @Published var playlists: [PlaylistModel?]?
    init() {
        getAlbums()
        getSingers()
        getPlaylists()
        
    }
    
    func getAlbums(){
        isAlbumsLoading = true
        FirestoreAlbumService.shared.getAlbums { albumModels, error in
            guard let albumModels = albumModels else {
             
                self.isAlbumsLoading = false
                return
            }
            
            
            self.albums = albumModels
            self.isAlbumsLoading = false
            
            self.albums?.enumerated().forEach { index, album in
//                FirestoreMusicService.shared.getMusics(ids: a)
                album?.musicIDs.forEach({ musicID in
                    FirestoreMusicService.shared.getMusicDetails(id: musicID) { [self] music in
                        self.albums?[index]?.musics.append(music)
                    }
                })
            }
            
        }
    }
    
    func getPlaylists(){
        guard let userID = UserDefaults.standard.string(forKey: UserDefaultKeys.User.rawValue) else {
            return
        }
        isPlaylistsLoading = true
        FirestorePlaylistService.shared.getPlaylists(userID: userID) { playlists, error in
            guard let playlists = playlists else {
                self.isPlaylistsLoading = false
                return
            }
            
            
            self.playlists = playlists
            self.isPlaylistsLoading = false
            
            self.playlists?.enumerated().forEach { index, playlist in
//                FirestoreMusicService.shared.getMusics(ids: a)
                playlist?.musicIDs.forEach({ musicID in
                    FirestoreMusicService.shared.getMusicDetails(id: musicID) { [self] music in
                        self.playlists?[index]?.musics.append(music)
                    }
                })
            }
            
        }
    }
    
    func getSingers(){
        isSingersLoading = true
        FirestoreSingerService.shared.getSingers{ data  in
            guard let data = data else {
                self.isSingersLoading = false
                return
            }
            self.singers = data
            self.isSingersLoading = false
        }
    }
}
