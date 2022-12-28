//
//  LoginButton.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 24.12.2022.
//

import SwiftUI

struct LoginButton: View {
    var text: String?
    var onClick: (() -> Void)?
    
   
    var body: some View {

        Button(action: onClick ?? {}, label: {
            HStack(){
                Image("googleicon").resizable().frame(width: 28, height: 28).padding(.horizontal)
//                Spacer()
                Text(text ?? "").bold().foregroundColor(.gray)
//                Spacer()
            }
        }).padding(10).frame(maxWidth: UIScreen.screenWidth / 1.3, alignment: .leading).background(.white).cornerRadius(12).shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            LoginButton(text: "Google ile giriş yap")
            LoginButton(text: "Facebook ile giriş yap")
        }
    }
}
