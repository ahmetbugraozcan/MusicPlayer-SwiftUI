//
//  AppTheme.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 28.12.2022.
//

import Foundation
import SwiftUI

class AppTheme: ObservableObject {
    
    @Published var isLightMode: Bool = UserDefaults.standard.bool(forKey: UserDefaultKeys.isLightTheme.rawValue)  {
        didSet {
            UserDefaults.standard.setValue(isLightMode, forKey: UserDefaultKeys.isLightTheme.rawValue)
            withAnimation {
                colorScheme = isLightMode  ? ColorScheme.light : ColorScheme.dark
            }
        }
    }
    
    @Published var colorScheme : ColorScheme = ColorScheme.light
    
    init(){
        self.isLightMode = UserDefaults.standard.bool(forKey: UserDefaultKeys.isLightTheme.rawValue)
        print("init \((UserDefaults.standard.value(forKey: UserDefaultKeys.isLightTheme.rawValue) as? Bool)?.description ?? "null")")
    }
}

extension ColorScheme { 

    func toString() -> String {
        return self == ColorScheme.dark ? "Karanlık Tema" : "Aydınlık Tema"
    }
}
