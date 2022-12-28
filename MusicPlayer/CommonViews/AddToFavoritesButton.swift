//
//  AddToFavoritesButton.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 26.12.2022.
//

import SwiftUI

struct AddToFavoritesButton: View {
    @State var isInFavorites = false
    var musicID: String?
    @EnvironmentObject var viewModel: FavoritesProvider
    
    init(musicID: String?) {
        if(musicID == nil) {return}
        self.musicID = musicID
        
    }
    
    var body: some View {
       
            Image(systemName: "heart.fill").foregroundColor(isInFavorites ? .red : .gray)
        .onAppear{
            if(musicID == nil) {return}
            isInFavorites = viewModel.favoriteMusicIDs?.contains(musicID!) ?? false
        }.onTapGesture{
            
              
                if(isInFavorites){
                    viewModel.removeMusicFromFavorites(self.musicID)
                    isInFavorites = false
                } else {
                    viewModel.addMusicToFavorites(self.musicID)
                    isInFavorites = true
                }
                
        
        }
    }
       
}

struct AddToFavoritesButton_Previews: PreviewProvider {
    static var previews: some View {
        AddToFavoritesButton(musicID: "xUUnNvU61eXBbdKcZsB7").environmentObject(FavoritesProvider())
    }
}
