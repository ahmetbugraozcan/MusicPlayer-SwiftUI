//
//  NowPlayingBar.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 25.12.2022.
//

import SwiftUI

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemChromeMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct NowPlayingBar<Content: View>: View {
    var content: Content

    @ViewBuilder var body: some View {
        ZStack(alignment: .bottom) {
            //content
            ZStack {
                Rectangle().foregroundColor(Color.white.opacity(0.0)).frame(width: UIScreen.main.bounds.size.width, height: 65).background(Blur())
                HStack {
                    Button(action: {}) {
                        HStack {
                            Image("cover").resizable().frame(width: 45, height: 45).shadow(radius: 6, x: 0, y: 3).padding(.leading)
                            Text("Shake It Off").padding(.leading, 10)
                            Spacer()
                        }
                    }.buttonStyle(PlainButtonStyle())
                    Button(action: {}) {
                        Image(systemName: "play.fill").font(.title3)
                    }.buttonStyle(PlainButtonStyle()).padding(.horizontal)
                    Button(action: {}) {
                        Image(systemName: "forward.fill").font(.title3)
                    }.buttonStyle(PlainButtonStyle()).padding(.trailing, 30)
                }
            }
        }
    }
}
struct ListenNowView: View {
    @State private var showMediaPlayer = false
    var body: some View {
        Button(action: {
            self.showMediaPlayer.toggle()
        }) {
            HStack {
                Image("Cover").resizable().frame(width: 45, height: 45).shadow(radius: 6, x: 0, y: 3).padding(.leading)
                Text("Shake It Off").padding(.leading, 10)
                Spacer()
            }
        }.buttonStyle(PlainButtonStyle()).fullScreenCover(isPresented: $showMediaPlayer) {
        
        }
    }
}
struct NowPlayingBar_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingBar(content: ListenNowView())
    }
}
