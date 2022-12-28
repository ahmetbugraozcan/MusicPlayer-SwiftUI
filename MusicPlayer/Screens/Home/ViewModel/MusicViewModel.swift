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

class MusicViewModel: ObservableObject {
    @Published var player: AVAudioPlayer!
    var isSliderDragging:Bool = false
    @Published var isMusicPlaying = false
    @Published var musicCurrentTime: TimeInterval = 0.0
    @Published var musicFinished = false
    var timer: Timer?
    
    
    init(filePath: URL?) {
  

        do{
            // sessize alındığında çalmaya devam
            try AVAudioSession.sharedInstance().setCategory(.playback, mode:.default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: filePath!)
            
            
            player.delegate?.audioPlayerDidFinishPlaying!(player, successfully: musicFinished)
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
                print("timerer")
                if self.isSliderDragging {
                  return
                }
                self.musicCurrentTime = self.player.currentTime
                if(round(self.musicCurrentTime) == round(self.player!.duration)){
                    self.onMusicFinish()
                    timer.invalidate()
                }
            })
            
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
