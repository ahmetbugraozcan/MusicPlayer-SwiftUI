//
//  ProfileVie.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 27.12.2022.
//

import SwiftUI
import Kingfisher

struct ProfileScreen: View {
    @State private var showingAlert = false
    @State private var showingLogOut = false
    @EnvironmentObject var appTheme: AppTheme
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State var todo: Todo?
    @State var string: String?
    init() {
        todo = UserDefaults.standard.object(forKey: "todotest") as? Todo
        string = UserDefaults.standard.string(forKey: "bgtest")
        
    }
    var body: some View {
        NavigationView{
            List{
                Section{
                    HStack{
                        KFImage(authViewModel.userModel?.photoURL).resizable().frame(width: 50,height: 50).cornerRadius(12)
                        Text(authViewModel.userModel?.name ?? "-")
                    }.frame(maxWidth: .infinity, alignment: .leading).listRowSeparator(.hidden)
                }header: {
                    Text("Kullanıcı Bilgileri")
                }
                Section{
                
                    Toggle("Karanlık Tema", isOn: $appTheme.isLightMode.not)
                    
                       
                } header: {
                    Text("Uygulama Teması")
                }
                Section{
                    Button("Onbelleği temizle"){
                        showingAlert.toggle()
                    }.foregroundColor(.red)
                    Button("Çıkış Yap"){
                        showingLogOut.toggle()
                    }.foregroundColor(.red).alert("Çıkış yapmak istediğinizden emin misiniz?",isPresented: $showingLogOut) {
                        Button("Çıkış Yap", role: .destructive){
                            UserDefaults.standard.removeObject(forKey: UserDefaultKeys.User.rawValue)
                            authViewModel.userModel = nil
                            authViewModel.state = SignInState.signedOut
                        }
                        Button("İptal", role: .cancel){}
                        
                    }
                } header: {
                    Text("Genel ayarlar")
                }
            }.navigationTitle("Ayarlar").alert("Önbelleği temizlemek istediğinizden emin misiniz?",isPresented: $showingAlert) {
                Button("Temizle", role: .destructive){
                    UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
                        UserDefaults.standard.removeObject(forKey: key)
                    }
                }
                Button("İptal", role: .cancel){}
            }
        }
//        VStack{
//            Text("Hello world")
//            Text("todo is \(todo?.title ?? "-")")
//            Text("string is \(string ?? "-")")
//        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen().environmentObject(AuthenticationViewModel()).environmentObject(AppTheme())
    }
}
