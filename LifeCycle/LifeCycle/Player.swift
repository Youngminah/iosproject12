//
//  Player.swift
//  LifeCycle
//
//  Created by meng on 2021/02/02.
//

import AVFoundation

// 플레이어가 재생중인지 아닌지?를 판단하기 위한 컴퓨티트 프로퍼티를 확장시켜 만들어주었다.
extension AVPlayer {
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}

class Player {
    // TODO: 싱글톤 만들기, 왜 만드는가?
    // 싱글톤 객체 => 객체를 한개만 만들고 여기저기서 쓴다.
    static let shared = Player()
    
    private let player = AVPlayer()

    var currentTime: Double {
        // TODO: currentTime 구하기
        return player.currentItem?.currentTime().seconds ?? 0
    }
    
    var totalDurationTime: Double {
        // TODO: totalDurationTime 구하기
        return player.currentItem?.duration.seconds ?? 0
    }
    
    var isPlaying: Bool {
        // TODO: isPlaying 구하기
        return player.isPlaying
    }
    
    var currentItem: AVPlayerItem? {
        // TODO: currentItem 구하기
        return player.currentItem
    }
    
    init() { }
    
    func pause() {
        // TODO: pause구현
        player.pause()
        
    }
    
    func play() {
        // TODO: play구현
        player.play()
        
    }
    
    func seek(to time:CMTime) {
        // TODO: seek구현
        player.seek(to: time)
        
    }
    
    func replaceCurrentItem(with item: AVPlayerItem?) {
        // TODO: replace current item 구현
        player.replaceCurrentItem(with: item)
        
    }
    
    func addPeriodicTimeObserver(forInterval: CMTime, queue: DispatchQueue?, using: @escaping (CMTime) -> Void) {
        player.addPeriodicTimeObserver(forInterval: forInterval, queue: queue, using: using)
    }
}
