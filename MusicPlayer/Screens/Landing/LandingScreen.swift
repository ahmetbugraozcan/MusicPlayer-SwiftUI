//
//  LandingScreen.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 23.12.2022.
//

import SwiftUI

struct LandingScreen: View {
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    @StateObject var appTheme = AppTheme()
    var body: some View {
        Group{
            if(authenticationViewModel.state == SignInState.loading){
                SplashScreen()
            } else if (authenticationViewModel.state == SignInState.signedOut){
                 LoginView()
            } else {
                 MainScreen()
            }
        }.environment(\.colorScheme, appTheme.colorScheme)
        .environmentObject(authenticationViewModel)
        .environmentObject(appTheme)
     
    }
}

struct LandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreen()
    }
}
