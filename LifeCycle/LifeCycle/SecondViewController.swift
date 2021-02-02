//
//  SecondViewController.swift
//  LifeCycle
//
//  Created by meng on 2021/02/01.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {

    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var playerButton: UIButton!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalDurationLabel: UILabel!
    
    var image : UIImage?
    var trackname : String?
    var artist : String?
    let simplePlayer = Player.shared
    
    var timeObserver: Any?
    var isSeeking: Bool = false
    
    func setData(){
        guard let trackname = self.trackname else {
            return
        }
        guard let trackimage = self.image else {
            return
        }
        self.playerImage.image = trackimage
        self.playerName.text = trackname
    }
    
    @IBAction func beginDrag(_ sender: UISlider){
        isSeeking = true
    }
    
    @IBAction func endDrag(_ sender: Any) {
        isSeeking = false
    }
    
    @IBAction func seek(_ sender: UISlider) {
        // TODO: 시킹 구현
        guard let currentItem = simplePlayer.currentItem else { return }
        let position = Double( sender.value)   // 0.... 1 사이의 비율로 나옴.
        let seconds = position * currentItem.duration.seconds
        let time = CMTime(seconds: seconds, preferredTimescale: 1000)
        simplePlayer.seek(to: time)
    }
    
    @IBAction func togglePlayButton(_ sender: UIButton) {
        // TODO: 플레이버튼 토글 구현
        if simplePlayer.isPlaying{
            simplePlayer.pause()
        } else {
            simplePlayer.play()
        }
        updatePlayButton()
    }
    
    func updateTintColor() {
        playerButton.tintColor = DefaultStyle.Colors.tint
        timeSlider.tintColor = DefaultStyle.Colors.tint
    }

    func updateTime(time: CMTime) {
        // print(time.seconds)
        // currentTime label, totalduration label, slider
        // TODO: 시간정보 업데이트, 심플플레이어 이용해서 수정
        currentTimeLabel.text = secondsToString(sec: simplePlayer.currentTime)   // 3.1234 >> 00:03
        totalDurationLabel.text = secondsToString(sec: simplePlayer.totalDurationTime)  // 39.2045  >> 00:39
        if isSeeking == false {
            // 노래 들으면서 시킹하면, 자꾸 슬라이더가 업데이트 됨, 따라서 시킹아닐때마 슬라이더 업데이트하자
            // TODO: 슬라이더 정보 업데이트
            timeSlider.value = Float(simplePlayer.currentTime/simplePlayer.totalDurationTime)
        }
    }
    
    func secondsToString(sec: Double) -> String {
        guard sec.isNaN == false else { return "00:00" }
        let totalSeconds = Int(sec)
        let min = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", min, seconds)
    }
    
    func updatePlayButton() {
        // TODO: 플레이버튼 업데이트 UI작업 > 재생/멈춤
        if simplePlayer.isPlaying{
            let configuration = UIImage.SymbolConfiguration(pointSize: 40)
            let image = UIImage(systemName: "pause.fill", withConfiguration: configuration)
            self.playerButton.setImage(image, for: .normal)
        } else {
            let configuration = UIImage.SymbolConfiguration(pointSize: 40)
            let image = UIImage(systemName: "play.fill", withConfiguration: configuration)
            self.playerButton.setImage(image, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePlayButton()
        updateTime(time: CMTime.zero)
        print("화면2: viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        setData()
        updateTintColor()
        print("\n화면2: viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("화면2: viewDidAppear")
        // TODO: TimeObserver 구현
        //Core Media Time 로 0.1초씩 관찰하기
        // CMTime(seconds: 1, preferredTimescale: 10) => 기준시간을 몇개로 분할? 0.1초임 결국
        //디스패치는 나중에 자세히 배움 => 0.1초마다 UILabel을 업데이트 해야하는데, main스레드한테 알려주겟다 하는 내용임.
        timeObserver = simplePlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 10) , queue: DispatchQueue.main, using: { time in self.updateTime(time: time)  }) //time은 곡의 현재 시간임.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("화면2: viewWillDisappear")
        simplePlayer.seek(to: CMTime.zero)
        simplePlayer.pause()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        simplePlayer.replaceCurrentItem(with: nil)
        print("화면2: viewDidDisappear")
    }
    
}
