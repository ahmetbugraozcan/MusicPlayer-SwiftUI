//
//  LoginView.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 22.12.2022.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel:AuthenticationViewModel
    var body: some View {
     
        ZStack{
          
            VStack {
                Spacer()
                VStack{
                    Text("Müzik Uygulamasına Hoşgeldin").font(.largeTitle).bold().multilineTextAlignment(.center)
                    Text("Birbirinden farklı sanatçılar, müzikler ve oynatma listeleri seni bekliyor!").bold().padding()
                }.padding(.top, 48)
                Spacer()
                LoginButton(text: "Google ile giriş yap", onClick: {
                    viewModel.signIn { isSuccess, error in
                    }
                }).padding(.bottom)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).foregroundColor(.white)
           
            if(viewModel.isLoggingIn){
                ZStack{
                    ProgressView()
                }.padding(24).background(.white).cornerRadius(12)
            }
        }.background{
            Image("concertwallpaper")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthenticationViewModel())
    }
}
