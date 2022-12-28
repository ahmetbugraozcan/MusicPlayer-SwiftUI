//
//  FavoritesProvider.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 26.12.2022.
//

import Combine
import Foundation

class FavoritesProvider: ObservableObject {
    @Published var favoriteMusicIDs: [String]? = []
    @Published var loadedmusics: [MusicModel?]? = []
    @Published var isFavoritesFetching: Bool = false
    
    init() {
        favoriteMusicIDs =  UserDefaults.standard.stringArray(forKey: UserDefaultKeys.Favorites.rawValue) ?? []
        getFavoriteMusics()
    }
    
    
    private func getFavoriteMusics(){
       
        favoriteMusicIDs?.forEach({ id in
            FirestoreMusicService.shared.getMusicDetails(id: id) { music in
                self.loadedmusics?.append(music)
            }
        })
        
    }
    
    func addMusicToFavorites(_ id: String?){
        if(id == nil){return}
        favoriteMusicIDs?.append(id!)
        FirestoreMusicService.shared.getMusicDetails(id: id) { music in
            self.loadedmusics?.append(music)
        }
        UserDefaults.standard.set(favoriteMusicIDs, forKey: UserDefaultKeys.Favorites.rawValue)
        
    }
    
    func removeMusicFromFavorites(_ id: String?){
        if(id == nil){return}
        favoriteMusicIDs?.removeAll{$0 == id}
        loadedmusics?.removeAll{$0?.id == id}
        UserDefaults.standard.set(favoriteMusicIDs, forKey: UserDefaultKeys.Favorites.rawValue)
        
    }
    
}
