//
//  SingleDetailsViewModel.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 26.12.2022.
//

import Foundation


class SingerDetailsViewModel: ObservableObject {
    @Published var musics: [MusicModel?]?
    
    @Published var singer: SingerModel? = nil {
        didSet {
            getSingerMusics()
        }
    }
    
    @Published var loading: Bool = false

    
    func getSingerMusics(){
        loading = true
        FirestoreSingerService.shared.getSingerMusics(id: singer?.uid) { musics, error in
            guard let musics = musics else {
                self.loading = false
                return
            }
            
            
            self.singer?.songs = musics
            self.musics = musics
            self.loading = false
            return
        }
    }
}
