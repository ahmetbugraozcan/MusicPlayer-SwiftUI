//
//  HomeViewModel.swift
//  MusicPlayer
//
//  Created by Ahmet Buğra Özcan on 10.12.2022.
//

import Foundation
import AVFoundation
import UIKit
import MediaPlayer

enum MusicType: String{
    case list
    case single
}

class MusicViewModel: ObservableObject {
   
    
    weak var task: URLSessionTask?
    
    @Published  var music: MusicModel?
    var musics: [MusicModel?]? = []
    
    @Published var nowPlayingMusic: MusicModel?
    
    @Published var player: AVAudioPlayer!
    var isSliderDragging:Bool = false
    @Published var isMusicPlaying = false
    @Published var musicCurrentTime: TimeInterval = 0.0
    @Published var musicFinished = false
    var timer: Timer?
    @Published var loading = true
    var musicType: MusicType?
  
    init(music: MusicModel?) {
        self.music = music
    }
    
    
    func initializeMusicSettings() {
    
        do{
            
            loading = true
            
            // sessize alındığında çalmaya devam
            try AVAudioSession.sharedInstance().setCategory(.playback, mode:.default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
            
            if let url = music?.musicFileURL {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    DispatchQueue.main.async {
                        do{
                            guard let musicData = data else {
                                
                                return
                                
                            }
                     
                            self.player = try AVAudioPlayer(data: musicData)
                            
                            
//                            self.player.delegate?.audioPlayerDidFinishPlaying!(self.player, successfully: self.musicFinished)
                            
                            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
                                
                                if self.isSliderDragging {
                                  return
                                }
                                self.musicCurrentTime = self.player.currentTime
                                if(round(self.musicCurrentTime) == round(self.player!.duration)){
                                    self.onMusicFinish()
                                    timer.invalidate()
                                }
                            })
                            self.nowPlayingMusic = self.music
                            self.playAudio()
                            self.loading = false
                            self.music?.data = data
                            
                           
                        } catch {
                            print("some error occured while playing url")
                        }
                    }
                    
                }
                task.resume()
                self.task = task
                
            } else {
                print("URL ERRORRRRRR")
            }
            
        } catch {
            print("Müzik çalınırken bir hata oluştu")
        }
        
        setupRemoteTransportControls()
    }
    
  
    func setupRemoteTransportControls() {
            let commandCenter = MPRemoteCommandCenter.shared()
            
            // Add handler for Play Command
            commandCenter.playCommand.addTarget { event in
                self.player?.play()
                return .success
            }
            
            // Add handler for Pause Command
            commandCenter.pauseCommand.addTarget { event in
                self.player?.stop()
                return .success
            }
            
        }
    
    func playAudio(){
        if musicFinished == true {
            timer = getTimer()
            musicFinished = false
        }
        
     
        if player?.isPlaying ?? false {
                player?.pause()
                isMusicPlaying = player?.isPlaying ?? false
                return;
        }
        else {
            player.play()
            isMusicPlaying = player.isPlaying
        }
        
        
    }
    
    private func onMusicFinish(){
        musicFinished = true
        isMusicPlaying = false
        playNextMusic()
    }
    
    
    func playNextMusic(){
        print("playnext1")
        print("playnext musics is \(musics)")
        guard let musics = musics  else {return}
        if(musicType == MusicType.list){
            print("playnext2")
            var newMusicIndex: Int = 0
            var musicIndex = musics.firstIndex(where: { musicmodel in
                musicmodel?.id == music?.id
            }) ?? 0
            
            if(musicIndex + 1 < musics.count){
                newMusicIndex = musicIndex + 1
            }
            
            music = musics[newMusicIndex]
            initializeMusicSettings()
            
        }
    }
    
    func playPreviousMusic(){
        if(musicType == MusicType.list){
            if(musics?.firstIndex(where: { musicmodel in
                musicmodel?.id == music?.id
            }) ?? 0 == 0){
                return
            }
            music = musics?[musics?.firstIndex(where: { musicmodel in
                musicmodel?.id == music?.id
            }) ?? 0 - 1]
            initializeMusicSettings()
        }
    }
    
    
    func checkMusicFinishAndStopIfEnd(){
        if(round(self.musicCurrentTime) == round(self.player!.duration)){
            onMusicFinish()
            timer?.invalidate()
        }
    }
    
    
    fileprivate func getTimer() -> Timer {
        
        return Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
        
            if self.isSliderDragging {
                return
            }
            
            self.musicCurrentTime = self.player.currentTime
            
            if(round(self.musicCurrentTime) == round(self.player!.duration)){
                self.onMusicFinish()
                timer.invalidate()
            }
        })
    }
    
}
