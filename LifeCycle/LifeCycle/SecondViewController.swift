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
    
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    var islikeup: Bool = false
    
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
        guard let trackartist = self.artist else {
            return
        }
        self.playerImage.image = trackimage
        self.playerName.text = trackname
        self.artistName.text = trackartist
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        let image = UIImage(systemName: "hand.thumbsup", withConfiguration: configuration)
        self.likeButton?.setImage(image, for: .normal)
        self.likeCount.text = "좋아요: \(simplePlayer.like)"
        islikeup = false
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
    
    @IBAction func likeClicked(_ sender: UIButton) {
        if (!islikeup) {
            let configuration = UIImage.SymbolConfiguration(pointSize: 20)
            let image = UIImage(systemName: "hand.thumbsup.fill", withConfiguration: configuration)
            self.likeButton?.setImage(image, for: .normal)
            islikeup = true
            simplePlayer.like += 1
            self.likeCount.text = "좋아요: \(simplePlayer.like)"
        }
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
            self.playerButton?.setImage(image, for: .normal)
        } else {
            let configuration = UIImage.SymbolConfiguration(pointSize: 40)
            let image = UIImage(systemName: "play.fill", withConfiguration: configuration)
            self.playerButton?.setImage(image, for: .normal)
        }
    }
    
    //맨처음 실행되는 생명주기
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePlayButton() //플레이버튼 업데이트
        updateTime(time: CMTime.zero) //실행을 처음부터 하게하기
        print("화면2: viewDidLoad")
    }

    //화면이 보여지기 직전.
    override func viewWillAppear(_ animated: Bool) {
        setData() //이전 화면에서 받아온 데이터 보여주기
        updateTintColor() //다크모드 대비
        print("\n화면2: viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("화면2: viewDidAppear")
        //타임 옵저버 추가
        timeObserver = simplePlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 10) , queue: DispatchQueue.main, using: { time in self.updateTime(time: time)  }) //time은 곡의 현재 시간임.
        simplePlayer.play() //화면이 뜨면 재생시키기
        updatePlayButton() //재생시키고 버튼모양도 바꿔주기
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("화면2: viewWillDisappear")
        simplePlayer.seek(to: CMTime.zero) //화면을 나가게 되면 다시 처음부터 시작한다.
        simplePlayer.pause() //재생 멈추기
        updatePlayButton() //재생 멈추고 플레이버튼 바꾸기
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        simplePlayer.replaceCurrentItem(with: nil) //화면이 사라지게 될때에는 플레이어에 들어가있는 현재 아이템을 빼준다.
        print("화면2: viewDidDisappear")
    }
    
}

