//
//  FavoritesScreen.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 24.12.2022.
//

import SwiftUI

struct FavoritesScreen: View {
    @EnvironmentObject var viewModel: FavoritesProvider
    var body: some View {
        NavigationView{
            VStack{
                if(viewModel.favoriteMusicIDs?.isEmpty ?? true){
                    LottieView(lottieFile: LottieEnums.musiclottie.rawValue).frame(width: 300,height: 300)
                    Text("Favoriler boş").font(.title)
                    Text("Yeni şarkılar dinle ve beğendiğin şarkıları favorilerine ekle.").multilineTextAlignment(.center).font(.subheadline).padding(.horizontal).padding(.vertical, 2)
                }
                List(viewModel.loadedmusics ?? [], id: \.?.id){ music in
                    MusicCard(music: music)
                }.listStyle(.automatic)
             
            }.frame(maxHeight: .infinity,alignment: .top)
        }
    }
}

struct FavoritesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesScreen().environmentObject(FavoritesProvider())
    }
}
